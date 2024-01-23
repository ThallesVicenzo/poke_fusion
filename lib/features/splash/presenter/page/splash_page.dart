import 'package:app_design/app_images.dart';
import 'package:app_design/pages/default_erro_page.dart';
import 'package:app_design/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/core/page_state.dart';

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
    widget.controller.state.addListener(listenableErrorState);
    super.initState();
  }

  void listenableErrorState() {
    final state = widget.controller.state.value;

    if (state is ErrorState) {
      Modular.to.pushNamed(
        MainRoutes.defaultError.route,
        arguments: ErrorPageParams(
          errorlog: state.asError.message,
          code: state.asError.code.toString(),
          onButtonPressed: (_) {
            widget.controller.getPokeData();
          },
        ),
      );
    }
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
            widget.controller.onAnimationEd(value);
          },
          child: const Center(
            child: AssetImageWidget(
              image: AppImage.logo,
              size: Size(300, 300),
            ),
          ),
        ),
      ),
    );
  }
}
