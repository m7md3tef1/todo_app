import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/utils.dart';
import '../../../core/data/api/api.dart';
import '../../../core/data/local/cacheHelper.dart';
import '../../../core/dialoges/toast.dart';
import '../../../core/keys/keys.dart';
import '../../../core/router/router.dart';
import '../cubit/todo_app_cubit.dart';
import '../view/login.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  bool value = true;
  bool socialAuth = false;
  Connectivity connectivity = Connectivity();
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SelfLabChangePasswordVisibilityState());
  }

  var phone;
  signIn(email, password, deviceType, deviceId, context) async {
    emit(SignInLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        var response = Api().postHttpLogin(url: 'sign-in', data: {
          'email': email,
          'password': password,
          'device_type': deviceType,
          'device_id': deviceId
        });
        response
            .then((value) async => {
                  TodoAppCubit.get(context).pageIndex = 0,
                  CacheHelper.putString(
                      SharedKeys.token, value['data']['token']),
                  token = CacheHelper.getString(SharedKeys.token),
                  emit(SignInSuccess(register: value)),
                  await getUserData(),
                  showToast(
                      msg: 'Login Successfully', state: ToastedStates.SUCCESS),
                  CacheHelper.putString(
                      SharedKeys.email, value['data']['email']),
                  email1 = CacheHelper.getString(SharedKeys.email),
                })
            .onError((error, stackTrace) => {
                  print(error),
                  emit(SignInFailed(error: error.toString())),
                });
      }
    });
  }

  signUp(userModel) async {
    emit(SignUpLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        var response = Api().postHttp(url: 'sign-up', data: userModel);
        response
            .then((value) => {
                  emit(SignUpSuccess()),
                  showToast(
                      msg: value['message'], state: ToastedStates.SUCCESS),
                })
            .onError((error, stackTrace) => {
                  print(error),
                  emit(SignUpFailed(error: error.toString())),
                  if (error.toString().contains('needActive'))
                    {
                      showToast(
                          msg: 'Your Account Is Not Active',
                          state: ToastedStates.ERROR),
                    }
                  else
                    showToast(
                        msg: error.toString().split(', errors:')[0].replaceAll(
                            'Exception: {status: false, message:', ''),
                        state: ToastedStates.ERROR),
                });
      }
    });
  }

  logout(context) async {
    emit(LogoutLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        var response = Api().deleteHttp(
            url: 'sign-out', authToken: token, data: {'device_id': id});
        response
            .then((value) async => {
                  MagicRouter.navigateAndPopAll(TodoAppLogin()),
                  emit(LogoutSuccess()),
                  showToast(
                      msg: 'Logout Successfully', state: ToastedStates.SUCCESS),
                  token = '',
                  token = CacheHelper.putString(SharedKeys.token, ''),
                })
            .onError((error, stackTrace) => {
                  emit(LogoutFailed(error.toString())),
                });
      }
    });
  }

  // Users? GetUserDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else if (token == '' || token == null) {
      } else {
        var response = Api().getHttp(
          url: 'profile',
          authToken: token,
        );
        response
            .then((value) => {
                  // GetUserDataModel =  Users.fromJson(value['data']['user']),
                  emit(GetUserDataSuccess(value['data']['user'])),
                })
            .onError((error, stackTrace) => {
                  emit(GetUserDataFailed(error)),
                });
      }
    });
  }

  // Users profileData2 =Users();
  updateProfile(name, email, phone, image) async {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        FormData formData;
        if (image == null) {
          formData = FormData.fromMap({
            'name': name,
            'email': email,
            'phone': phone,
          });
        } else {
          String fileName = image != null ? image!.split('/').last : '';

          formData = FormData.fromMap({
            'image': await MultipartFile.fromFile(image!, filename: fileName),
            'name': name,
            'email': email,
            'phone': phone,
          });
        }

        var token = await CacheHelper.getString(SharedKeys.token);
        var response = Api().postHttp(
            url: 'update-profile?_method=patch',
            data: formData,
            authToken: token);
        emit(UpdateLoading());
        response
            .then((value) => {
                  // GetUserDataModel =  Users.fromJson(value['data']['user']),
                  emit(UpdateSuccess(value['data']['user'])),
                  showToast(
                      msg: 'update Profile successfully',
                      state: ToastedStates.SUCCESS),
                })
            .onError((error, stackTrace) => {
                  showToast(
                      msg: error.toString().split(', errors:')[0].replaceAll(
                          'Exception: {status: false, message:', ''),
                      state: ToastedStates.ERROR),
                  emit(UpdateFailed(error)),
                });
      }
    });
  }
}
