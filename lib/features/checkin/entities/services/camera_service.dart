import 'dart:developer';
import 'dart:io' show Platform;
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:injectable/injectable.dart';

@injectable
class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  InputImageRotation? _cameraRotation;
  InputImageRotation? get cameraRotation => _cameraRotation;

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
    try {
      await _cameraController?.startImageStream(onAvailable);
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
}
