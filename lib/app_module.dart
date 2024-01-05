import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/splash/splash_module.dart';
import 'package:poke_fusion/features/home/home_module.dart';
import 'package:poke_fusion/core/main_routes.dart';

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
      MainRoutes.home.route,
      module: HomeModule(),
    );
  }
}
