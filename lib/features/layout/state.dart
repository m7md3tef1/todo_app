part of 'cubit.dart';

@immutable
abstract class SelfLabState {}

class SelfLabInitial extends SelfLabState {}

class SelfLabChangeBottomNavState extends SelfLabState {}
class SelfLabChangeIndexState extends SelfLabState {}

class ImageCamera extends SelfLabState {}

class ImageCameraLoading extends SelfLabState {}

class ImageGalleryLoading extends SelfLabState {}

class ImageGallery extends SelfLabState {}

class NetworkTokenFailed extends SelfLabState {
  final String msg;
  NetworkTokenFailed(this.msg);
}

//sign_in
class RefreshTokenLoading extends SelfLabState {}

class RefreshTokenSuccess extends SelfLabState {
  var register;
  RefreshTokenSuccess();
}

class RefreshTokenFailed extends SelfLabState {
  String? error;
  RefreshTokenFailed({this.error});
}
