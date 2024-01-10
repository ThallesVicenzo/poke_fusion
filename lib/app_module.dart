import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/splash/splash_module.dart';
import 'package:poke_fusion/core/main_routes.dart';

import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<Dio>(
          (i) => Dio(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          MainRoutes.splash.route,
          module: SplashModule(),
        ),
        ModuleRoute(
          MainRoutes.home.route,
          module: HomeModule(),
        ),
      ];
}
