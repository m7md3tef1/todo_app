part of 'edit_task_cubit.dart';

sealed class EditTaskState {}

final class AddTaskInitial extends EditTaskState {}

class NetworkFailed extends EditTaskState {
  final String msg;
  NetworkFailed(this.msg);
}

//sign_in
class AddTaskLoading extends EditTaskState {}

class AddTaskSuccess extends EditTaskState {
  AddTaskSuccess();
}

class AddTaskFailed extends EditTaskState {
  AddTaskFailed();
}
