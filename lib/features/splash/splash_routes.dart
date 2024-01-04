import 'package:poke_fusion/main_routes.dart';

enum SplashRoutes {
  splashPage('/');

  const SplashRoutes(this.route);

  final String route;

  String get path => MainRoutes.splash.route + route;
}
