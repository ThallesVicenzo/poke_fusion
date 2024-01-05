import '../../core/main_routes.dart';

enum HomeRoutes {
  homePage('/');

  const HomeRoutes(this.route);

  final String route;

  String get path => MainRoutes.home.route + route;
}
