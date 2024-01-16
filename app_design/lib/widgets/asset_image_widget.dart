import 'package:app_design/app_images.dart';
import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final AppImage image;
  final Size size;
  final BoxFit fit;
  final Alignment alignment;
  final String? package;

  const AssetImageWidget({
    super.key,
    required this.image,
    this.size = const Size(24, 24),
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.package = 'app_design',
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image.path,
      semanticLabel: image.name,
      width: size.width,
      height: size.height,
      fit: fit,
      alignment: alignment,
      package: package,
    );
  }
}
