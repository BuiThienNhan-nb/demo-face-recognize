import 'package:flutter/material.dart';

class AppLoading {
  AppLoading._internal();

  static bool isLoading = false;

  static showLoadingDialog(BuildContext context) {
    if (!isLoading) {
      showDialog(
        context: context,
        builder: (_) => const Material(
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
      );
      isLoading = true;
    }
  }

  static dismissLoadingDialog(BuildContext context) {
    if (isLoading) {
      Navigator.of(context).pop();
      isLoading = false;
    }
  }
}
