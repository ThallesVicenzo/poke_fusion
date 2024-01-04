import '../../main_routes.dart';

enum WelcomeRoutes {
  welcomePage('/');

  const WelcomeRoutes(this.route);

  final String route;

  String get path => MainRoutes.welcome.route + route;
}
