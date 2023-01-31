import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Face Recognize"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                GoRouter.of(context).pushNamed("check_in");
              },
              child: const Text("Check In"),
            ),
            MaterialButton(
              onPressed: () {
                GoRouter.of(context).pushNamed("register_face");
              },
              child: const Text("Register Face"),
            ),
          ],
        ),
      ),
    );
  }
}
