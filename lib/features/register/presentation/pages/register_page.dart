import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../../main.dart';
import '../../../checkin/entities/model/user_model.dart';
import '../../../checkin/entities/services/camera_service.dart';
import '../../../checkin/entities/services/face_detector_service.dart';
import '../../../checkin/entities/services/ml_service.dart';
import '../../../checkin/presentation/widgets/camera_preview_widget.dart';
import '../../../checkin/presentation/widgets/face_painter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controller = TextEditingController();
  FaceDetectorService detectorService = GetIt.I<FaceDetectorService>();
  CameraService cameraService = GetIt.I<CameraService>();
  MLService mlService = GetIt.I<MLService>();
  Face? faceDetected;
  Size? size;

  bool _canProcess = true;
  bool _isBusy = false;
  bool _saving = false;

  @override
  void dispose() {
    _canProcess = false;
    detectorService.faceDetector.close();
    cameraService.dispose();
    super.dispose();
  }

  Future<bool> onShot() async {
    if (faceDetected == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('No face detected!'),
          );
        },
      );

      return false;
    } else {
      setState(() {
        _saving = true;
      });

      return true;
    }
  }

  Future<void> processImage(
    InputImage inputImage,
    CameraImage cameraImage,
    Size imageSize,
  ) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {});

    await detectorService.faceDetector.processImage(inputImage).then(
      (faces) async {
        if (faces.isNotEmpty) {
          size = imageSize;
          faceDetected = faces.first;
          if (_saving) {
            final data =
                mlService.generateFloat32List(cameraImage, faceDetected);
            UserModel user = UserModel(
              id: "id",
              name: controller.text.trim(),
              faceInfo: data,
            );
            setState(() {
              _saving = false;
              currentAppUsers.add(user);
              log("done!");
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Register face successfully!"),
              ),
            );
            GoRouter.of(context).pop();
          }
        }
      },
    );

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register Face"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          CameraView(
            onImage: (inputImage, cameraImage, size) {
              processImage(inputImage, cameraImage, size);
            },
          ),
          if (faceDetected != null)
            CustomPaint(
              painter: FacePainter(
                imageSize: size!,
                face: faceDetected,
              ),
            ),
          Container(
            height: 100.h,
            width: 50.w,
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter user name...",
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  onPressed: onShot,
                  icon: const Icon(
                    Icons.app_registration_rounded,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
