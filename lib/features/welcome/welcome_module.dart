import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/welcome_page.dart';
import 'welcome_routes.dart';

class WelcomeModule extends Module {
  @override
  void routes(r) {
    r.child(
      WelcomeRoutes.welcomePage.route,
      child: (context) => const WelcomePage(),
    );
  }
}
