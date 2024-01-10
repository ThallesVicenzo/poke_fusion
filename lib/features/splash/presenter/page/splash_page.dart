import 'dart:async';

import 'package:app_design/app_images.dart';
import 'package:app_design/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/main_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        opacity = 0;
      });
    });
    super.initState();
  }

  double opacity = 1;

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
            size: Size(300, 300),
          ),
        ),
      ),
    );
  }
}
