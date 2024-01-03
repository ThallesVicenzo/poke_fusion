import 'package:flutter/material.dart';

import 'features/splash/presenter/page/splash_page.dart';

class PokeFusion extends StatelessWidget {
  const PokeFusion({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashPage(),
    );
  }
}
