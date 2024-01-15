import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/controller/home_controller.dart';
import 'presenter/pages/home_page.dart';
import 'home_routes.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory(
          (i) => HomeController(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HomeRoutes.homePage.route,
          child: (context, args) => HomePage(
            controller: context.read<HomeController>(),
            pokeData: args.data,
          ),
        ),
      ];
}
