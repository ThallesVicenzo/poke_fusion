import 'package:app_design/widgets/ui_overlay_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/main_routes.dart';

class PokeFusion extends StatelessWidget {
  const PokeFusion({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(MainRoutes.splash.route);

    return MaterialApp.router(
      title: 'PokeFusion',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.red,
      ),
      builder: (context, child) {
        return UiOverlayColor(
          child: child!,
        );
      },
    );
  }
}
