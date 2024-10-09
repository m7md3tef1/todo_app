part of 'todo_app_cubit.dart';

abstract class TodoAppState {}

class RegisterInitial extends TodoAppState {}

class NetworkFailed extends TodoAppState {
  final String msg;
  NetworkFailed(this.msg);
}

class SelfLabChangePasswordVisibilityState extends TodoAppState {}

class SelfLabChangeConfirmPasswordVisibilityState
    extends TodoAppState {}

class SelfLabChangeAddressState extends TodoAppState {}

class SelfLabChangeOldPasswordVisibilityState extends TodoAppState {}

class SelfLabIndexState extends TodoAppState {}

