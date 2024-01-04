enum AppImage {
  logo('logo.png');

  const AppImage(this.name);

  final String name;

  String get _defaultPath => 'assets/images/';

  String get path => '$_defaultPath$name';
}
