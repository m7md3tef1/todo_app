import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/utils.dart';
import '../../../core/models/tasks.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  static TasksCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();
  List<Tasks> listTasks = [];
  var pageNumberFilter = 1;
  Future<void> getTasks(context, {bool fromLoading = false}) async {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        if (fromLoading) {
          emit(GetTasksPaginationLoading());
        } else {
          pageNumberFilter = 1;
          listTasks.clear();
          listTasks = [];
          print(pageNumberFilter);
          print(listTasks.length);
          emit(GetTasksLoading());
        }
        try {
          var response = await Dio()
              .get('https://todo.iraqsapp.com/todos?page=$pageNumberFilter',
                  options: Options(
                    headers: {
                      "Authorization": 'Bearer $token',
                    },
                  ));
          var model = TaskData.fromJson(response.data);
          if (model.list.isNotEmpty) {
            pageNumberFilter++;
            listTasks.addAll(model.list);
          }
          print(listTasks.length);
          emit(GetTasksSuccess(listTasks));
        } on DioError catch (ex) {
          print(ex.error.toString());
          emit(GetTasksFailed(ex.toString()));
        }
      }
    });
  }
}

class TaskData {
  late final List<Tasks> list;

  TaskData.fromJson(dynamic json) {
    list = List.from(json).map((e) => Tasks.fromJson(e)).toList();
  }
}
