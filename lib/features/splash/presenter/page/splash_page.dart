import 'dart:async';

import 'package:app_design/app_images.dart';
import 'package:app_design/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../main_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashPage> {
  double opacity = 1;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        opacity = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: opacity,
        duration: kThemeAnimationDuration,
        onEnd: () {
          if (opacity == 0) {
            Modular.to.navigate(MainRoutes.home.route);
          }
        },
        child: const Center(
          child: AppImageWidget(
            image: AppImage.logo,
            size: Size(350, 350),
          ),
        ),
      ),
    );
  }
}
