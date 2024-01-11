import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiOverlayColor extends StatelessWidget {
  const UiOverlayColor(
      {super.key, required this.child, this.overlayColor, this.brightness});

  final Widget child;
  final Color? overlayColor;
  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: overlayColor ?? const Color(0xffE6E6E6),
        statusBarIconBrightness: brightness ?? Brightness.dark,
      ),
      child: child,
    );
  }
}
