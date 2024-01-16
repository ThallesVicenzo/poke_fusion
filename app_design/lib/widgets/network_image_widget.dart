import 'package:flutter/cupertino.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;
  final Size size;
  final BoxFit fit;
  final Alignment alignment;
  final String? package;

  const NetworkImageWidget({
    super.key,
    required this.url,
    this.size = const Size(24, 24),
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.package = 'app_design',
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: size.width,
      height: size.height,
      fit: fit,
      alignment: alignment,
    );
  }
}
