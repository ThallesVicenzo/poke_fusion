import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/splash/splash_module.dart';
import 'package:poke_fusion/features/welcome/welcome_module.dart';
import 'package:poke_fusion/main_routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(
      MainRoutes.splash.route,
      module: SplashModule(),
    );
    r.module(
      MainRoutes.welcome.route,
      module: WelcomeModule(),
    );
  }
}
