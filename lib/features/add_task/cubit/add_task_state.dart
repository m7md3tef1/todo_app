part of 'add_task_cubit.dart';

sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

class NetworkFailed extends AddTaskState {
  final String msg;
  NetworkFailed(this.msg);
}

//sign_in
class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {
  AddTaskSuccess();
}

class AddTaskFailed extends AddTaskState {
  AddTaskFailed();
}
