import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:face_recognize_demo/base/base_state.dart';
import 'package:face_recognize_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';

import '../../entities/model/user_model.dart';
import '../../entities/services/camera_service.dart';
import '../../entities/services/face_detector_service.dart';
import '../../entities/services/ml_service.dart';
import '../states/check_in_store.dart';
import '../widgets/camera_preview_widget.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  FaceDetectorService detectorService = GetIt.I<FaceDetectorService>();
  CameraService cameraService = GetIt.I<CameraService>();
  MLService mlService = GetIt.I<MLService>();
  CheckInStore? store;
  Face? faceDetected;

  bool _canProcess = true;
  bool _isBusy = false;
  bool _checkIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = context.read<CheckInStore>();
  }

  @override
  void dispose() {
    _canProcess = false;
    detectorService.faceDetector.close();
    super.dispose();
  }

  Future<bool> checkIn() async {
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
        _checkIn = true;
      });

      return true;
    }
  }

  Future<void> processImage(
    InputImage inputImage,
    CameraImage cameraImage,
  ) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {});

    await detectorService.faceDetector.processImage(inputImage).then(
      (faces) async {
        if (faces.isNotEmpty) {
          faceDetected = faces.first;
          if (_checkIn) {
            log(currentAppUsers.toString());
            final data =
                mlService.generateFloat32List(cameraImage, faceDetected);
            UserModel? user = await mlService.predict(data);
            String? error;
            if (user == null) {
              error = "Cannot find any user with this face info!";
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(error ??
                      "Check in Successfully! Have a nice day ${user!.name}"),
                );
              },
            );
            setState(() {
              _checkIn = false;
            });
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
    return Observer(
      builder: (_) {
        if (store?.state == BaseState.init) {
          store!.getAllUsers();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Check In"),
            centerTitle: true,
          ),
          body: store!.state == BaseState.loaded
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CameraView(
                      onImage: (inputImage, cameraImage) {
                        processImage(inputImage, cameraImage);
                      },
                    ),
                    TextButton(
                      onPressed: checkIn,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text("Check In"),
                    ),
                  ],
                )
              : Center(
                  child: store!.state == BaseState.loading
                      ? const CircularProgressIndicator()
                      : Text(store!.errorMessage ?? "Unexpected Error!"),
                ),
        );
      },
    );
  }
}
