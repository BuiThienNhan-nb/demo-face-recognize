import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

extension CreateInputImage on CameraImage {
  InputImage toInputImage(InputImageRotation rotation) {
    InputImageData firebaseImageMetadata = InputImageData(
      imageRotation: rotation,
      inputImageFormat: InputImageFormat.bgra8888,
      size: Size(
        width.toDouble(),
        height.toDouble(),
      ),
      planeData: planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );

    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    return InputImage.fromBytes(
      bytes: bytes,
      inputImageData: firebaseImageMetadata,
    );
  }
}
