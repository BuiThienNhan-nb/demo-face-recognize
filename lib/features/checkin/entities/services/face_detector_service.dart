
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/extensions/image_extensions.dart';
import 'camera_service.dart';

@lazySingleton
class FaceDetectorService {
  CameraService cameraService = GetIt.I<CameraService>();
  List<Face> _faces = [];

  List<Face> get faces => _faces;

  bool get faceDetected => _faces.isNotEmpty;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
    ),
  );

  Face? face;

  FaceDetector get faceDetector => _faceDetector;

  InputImage createInputImageFromCameraImage(
          CameraImage image, InputImageRotation rotation) =>
      image.toInputImage(rotation);

  InputImage createInputImageFromAssetImage(String filePath) =>
      InputImage.fromFilePath(filePath);

  Future<void> detectFacesFromImage(CameraImage image) async {

    InputImage _firebaseVisionImage =  image.toInputImage(InputImageRotation.rotation0deg);

    _faces = await _faceDetector.processImage(_firebaseVisionImage);
  }
}
