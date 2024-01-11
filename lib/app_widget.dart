import 'package:app_design/widgets/ui_overlay_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/core/main_routes.dart';

class PokeFusion extends StatelessWidget {
  const PokeFusion({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(MainRoutes.splash.route);
    return MaterialApp.router(
      title: 'Poke Fusion',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffE6E6E6),
      ),
      builder: (context, child) {
        return UiOverlayColor(
          child: child!,
        );
      },
    );
  }
}
