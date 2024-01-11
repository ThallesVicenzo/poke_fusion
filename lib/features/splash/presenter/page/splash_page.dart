import 'package:app_design/app_images.dart';
import 'package:app_design/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/main_routes.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  final SplashController controller;
  const SplashPage({
    super.key,
    required this.controller,
  });

  @override
  State<SplashPage> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashPage> {
  @override
  void initState() {
    widget.controller.getPokeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: widget.controller.opacity,
        builder: (context, value, child) => AnimatedOpacity(
          opacity: value,
          duration: kThemeAnimationDuration,
          onEnd: () {
            if (value == 0) {
              Modular.to.navigate(
                MainRoutes.home.route,
                arguments: widget.controller.state.value.asSuccess,
              );
            }
          },
          child: const Center(
            child: AppImageWidget(
              image: AppImage.logo,
              size: Size(300, 300),
            ),
          ),
        ),
      ),
    );
  }
}
