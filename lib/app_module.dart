import 'package:app_design/pages/default_erro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/core/client/client_http.dart';
import 'package:poke_fusion/core/client/dio/dio_client.dart';
import 'package:poke_fusion/features/splash/splash_module.dart';
import 'package:poke_fusion/core/main_routes.dart';

import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<ClientHttp>(
          (i) => DioClient(),
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
        ChildRoute(
          MainRoutes.defaultError.route,
          child: (context, args) {
            final erroParams = args.data is ErrorPageParams
                ? (args.data as ErrorPageParams)
                : const ErrorPageParams();
            return DefaultErrorPage(
              params: erroParams,
              onBackStart: () {
                Modular.to.navigate(MainRoutes.home.route);
              },
            );
          },
        ),
      ];
}
