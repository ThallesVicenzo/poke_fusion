import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/home_page.dart';
import 'home_routes.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child(
      HomeRoutes.homePage.route,
      child: (context) => const HomePage(),
    );
  }
}
