import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/color_manager/color_manager.dart';

part 'state.dart';

class SelfLabCubit extends Cubit<SelfLabState> {
  SelfLabCubit() : super(SelfLabInitial());
  static SelfLabCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();
  int currentIndex = 0;
  int index = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit(SelfLabChangeBottomNavState());
  }
  void changeIndex(int i,context) {
    index = i;
    emit(SelfLabChangeIndexState());
  }
  var image;
  var image1;
  pickFromCamera(context) async {
    Navigator.of(context).pop();
    var img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) {
      emit(ImageCameraLoading());
      final filePath = File(img.path).path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
      var result = await FlutterImageCompress.compressAndGetFile(
        File(img.path).path,
        outPath,
        quality: 80,
      );
      image = result!.path;
      emit(ImageCamera());
      return result;
    }
    emit(ImageCamera());
  }

  pickFromGallery(context) async {
    Navigator.of(context).pop();
    const SpinKitFadingCircle(
      color: ColorManager.backgroundColor,
      size: 70.0,
    );
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      emit(ImageGalleryLoading());
      final filePath = File(img.path).path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final outPath = '${filePath}_out${filePath.substring(lastIndex)}';
      var result = await FlutterImageCompress.compressAndGetFile(
        File(img.path).path,
        outPath,
        quality: 10,
      );
      image = result!.path;
      emit(ImageGallery());
      return result;
    }
    emit(ImageGallery());
  }
}
