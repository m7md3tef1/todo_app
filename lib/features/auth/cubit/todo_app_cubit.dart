import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_app_state.dart';

class TodoAppCubit extends Cubit<TodoAppState> {
  TodoAppCubit() : super(RegisterInitial());
  static TodoAppCubit get(context) => BlocProvider.of(context);
  var flag;
  var lat;
  var long;

  var address;
  var lat1;
  var long1;

  IconData suffix = Icons.visibility_off_outlined;
  IconData suffix1 = Icons.visibility_off_outlined;
  IconData suffix2 = Icons.visibility_off_outlined;
  bool? value = false;
  bool isPassword = true;

  bool isConfirmPassword = true;
  bool oldPassword = true;
  Connectivity connectivity = Connectivity();
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SelfLabChangePasswordVisibilityState());
  }

  void changeAddress() {
    address;
    emit(SelfLabChangeAddressState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    suffix1 = isConfirmPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(SelfLabChangeConfirmPasswordVisibilityState());
  }

  void changeOldPasswordVisibility() {
    oldPassword = !oldPassword;
    suffix2 =
        oldPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SelfLabChangeOldPasswordVisibilityState());
  }

  int pageIndex = 0;
  int pageIndex1 = 0;

  getIndex(currentIndex) {
    pageIndex = currentIndex;
    emit(SelfLabIndexState());
  }

  getIndex1(currentIndex1) {
    pageIndex1 = currentIndex1;
    emit(SelfLabIndexState());
  }
}
