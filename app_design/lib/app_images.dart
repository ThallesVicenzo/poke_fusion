enum AppImage {
  logo('logo.png'),
  pikachuError('pikachuError.gif');

  const AppImage(this.name);

  final String name;

  String get _defaultPath => 'assets/images/';

  String get path => '$_defaultPath$name';
}
