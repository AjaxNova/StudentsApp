import 'package:flutter/material.dart';
import 'package:student_app/core/constant/functions.dart';
import 'package:student_app/presentation/home/screen_home.dart';

import '../../core/constant/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    gotoHome(context);
    return Scaffold(
      backgroundColor: backgroundGradient.colors[1],
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

gotoHome(context) {
  Future.delayed(
    const Duration(milliseconds: 500),
    () {
      goto(context: context, pageTogo: const ScreenHome());
    },
  );
}
