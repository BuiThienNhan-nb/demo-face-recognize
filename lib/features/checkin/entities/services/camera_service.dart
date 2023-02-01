import 'dart:developer';
import 'dart:io' show Platform;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:injectable/injectable.dart';

import 'face_detector_service.dart';
import 'ml_service.dart';

@injectable
class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  InputImageRotation? _cameraRotation;
  InputImageRotation? get cameraRotation => _cameraRotation;

  bool _detectingFaces = false;
  bool pictureTaken = false;
  Face? faceDetected;

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future<void> initialize() async {
    if (_cameraController != null) return;
    CameraDescription description = await _getCameraDescription();
    await _setupCameraController(description: description);
    _cameraRotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );
  }

  Future<CameraDescription> _getCameraDescription() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
        camera.lensDirection == CameraLensDirection.front);
  }

  Future _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup:
          Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.yuv420,
    );
    await _cameraController?.initialize();
  }

  InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.rotation0deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Future<XFile?> takePicture() async {
    assert(_cameraController != null, 'Camera controller not initialized');
    await _cameraController?.stopImageStream();
    XFile? file = await _cameraController?.takePicture();
    _imagePath = file?.path;
    return file;
  }

  startStream(Function(CameraImage) onAvailable) async {
    MLService mlService = GetIt.I<MLService>();
    FaceDetectorService detectorService = GetIt.I<FaceDetectorService>();
    try {
      await _cameraController?.startImageStream((onAvailable) async {
        if (cameraController != null) {
          try {
            if (_detectingFaces) return;

            _detectingFaces = true;

            try {
              await detectorService.detectFacesFromImage(onAvailable);

              if (detectorService.faces.isNotEmpty) {
                faceDetected = detectorService.faces[0];

                mlService.setCurrentPrediction(onAvailable, faceDetected);
              } else {
                faceDetected = null;
              }

              _detectingFaces = false;
            } catch (e) {
              print(2);
              print(e);
              _detectingFaces = false;
            }
          } catch (e) {
            print(e);
            print(1);
          }
        }
      });
    } on CameraException catch (e) {
      log("Start stream error: $e");
      _cameraController?.stopImageStream();
      _cameraController?.startImageStream(onAvailable);
    }
  }

  Future<void> stopStream() async {
    try {
      await cameraController?.stopImageStream();
    } catch (e) {
      log("Stop stream error: $e");
    }
  }

  Future<void> dispose() async {
    try {
      await _cameraController?.dispose();
      _cameraController = null;
    } catch (e) {
      log("Dispose camera error: $e");
    }
  }

  Size getImageSize() {
    assert(cameraController != null, 'Camera controller not initialized');
    assert(cameraController!.value.previewSize != null, 'Preview size is null');
    return Size(
      cameraController!.value.previewSize!.height,
      cameraController!.value.previewSize!.width,
    );
  }
}
