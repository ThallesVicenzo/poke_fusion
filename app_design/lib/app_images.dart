enum AppImage {
  logo('logo.png'),
  pikachuErrpr('pikachuError.gif');

  const AppImage(this.name);

  final String name;

  String get _defaultPath => 'assets/images/';

  String get path => '$_defaultPath$name';
}
