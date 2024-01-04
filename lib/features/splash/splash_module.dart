import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/splash/presenter/page/splash_page.dart';
import 'package:poke_fusion/features/splash/splash_routes.dart';

class SplashModule extends Module {
  @override
  void routes(r) {
    r.child(
      SplashRoutes.splashPage.route,
      child: (context) => const SplashPage(),
    );
  }
}
