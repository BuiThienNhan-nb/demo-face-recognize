import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/extensions/image_extensions.dart';

@lazySingleton
class FaceDetectorService {
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
}
