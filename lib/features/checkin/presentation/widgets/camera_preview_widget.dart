import 'package:camera/camera.dart';
import 'package:face_recognize_demo/features/checkin/entities/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../FaceDetector/facePainter.dart';
import '../../entities/services/camera_service.dart';
import '../../entities/services/face_detector_service.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    Key? key,
    required this.onImage,
  }) : super(key: key);

  final Function(
    InputImage inputImage,
    CameraImage cameraImage,
  ) onImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;
  bool pictureTaken = false;
  CameraService cameraService = GetIt.I<CameraService>();
  FaceDetectorService faceDetectorService = GetIt.I<FaceDetectorService>();

  bool _initializing = false;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    // cameraService.stopStream();
  }

  initCamera() async {
    setState(() => _initializing = true);
    await GetIt.I<MLService>().initialize();
    await cameraService.initialize().then(
      (_) {
        if (!mounted) {
          return;
        }
        cameraService.startStream(processCameraImage);
        setState(() {});
      },
    );
    setState(() => _initializing = false);
  }

  Future processCameraImage(CameraImage cameraImage) async {
    final InputImage inputImage =
        faceDetectorService.createInputImageFromCameraImage(
      cameraImage,
      cameraService.cameraRotation!,
    );

    widget.onImage(
      inputImage,
      cameraImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return _initializing
        ? const Center(child: CircularProgressIndicator())
        : Transform.scale(
            scale: 1.0,
            child: AspectRatio(
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: SizedBox(
                    width: width,
                    height: width *
                        cameraService.cameraController!.value.aspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CameraPreview(
                          cameraService.cameraController!,
                        ),
                        if (faceDetectorService.faceDetected)
                          CustomPaint(
                            painter: FacePainter(
                              face: faceDetectorService.faces[0],
                              imageSize: cameraService.getImageSize(),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
    // return _initializing
    //     ? const Center(child: CircularProgressIndicator())
    //     : AspectRatio(
    //         aspectRatio: 1 / cameraService.cameraController!.value.aspectRatio,
    //         child: CameraPreview(cameraService.cameraController!),
    //       );
  }
}
