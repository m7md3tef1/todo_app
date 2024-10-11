import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/const/utils.dart';
import 'package:project/core/router/router.dart';
import 'package:project/features/homeScreen/cubit/tasks_cubit.dart';

import '../../../core/data/api/api.dart';
import '../../../core/dialoges/toast.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  static AddTaskCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();
  addImage(image, title, desc, priority, dueDate, context) async {
    emit(AddImageLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        FormData formData;
        String fileName = image != null ? image!.split('/').last : '';

        formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(image!, filename: fileName)
        });
        var response = Api().postHttp(context,
            url: 'upload/image', authToken: token, data: formData);
        response
            .then((value) async => {
                  print(value['image']),
                  addTask(
                      value['image'], title, desc, priority, dueDate, context),
                  emit(AddImageSuccess()),
                  showToast(
                      msg: 'Added Image Successfully',
                      state: ToastedStates.SUCCESS),
                  MagicRouter.pop(),
                })
            .onError(
                (error, stackTrace) => {print(error), emit(AddImageFailed())});
      }
    });
  }

  addTask(image, title, desc, priority, dueDate, context) async {
    emit(AddTaskLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.WARNING);
      } else {
        var response = Api().postHttp(context,
            url: 'todos',
            authToken: token,
            data: jsonEncode({
              'image': image,
              'title': title,
              'desc': desc,
              'priority': priority,
              'dueDate': dueDate
            }));
        response
            .then((value) async => {
                  emit(AddTaskSuccess()),
                  TasksCubit.get(context).pageNumberFilter = 1,
                  TasksCubit.get(context).listTasks = [],
                  TasksCubit.get(context).getTasks(context, fromLoading: false),
                  showToast(
                      msg: 'Added Task Successfully',
                      state: ToastedStates.SUCCESS),
                  MagicRouter.pop(),
                })
            .onError(
                (error, stackTrace) => {print(error), emit(AddTaskFailed())});
      }
    });
  }
}
