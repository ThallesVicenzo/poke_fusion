enum MainRoutes {
  splash('/splash'),
  home('/home'),
  defaultError('/defaultErrorPage');

  const MainRoutes(this.route);

  final String route;
}
