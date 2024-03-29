import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.title,
    this.size,
    this.desable = false,
    required this.onPressed,
  });

  final Size? size;
  final String title;
  final VoidCallback onPressed;
  final bool desable;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: desable,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: size?.width ?? MediaQuery.of(context).size.width * 0.4,
            minHeight: size?.height ?? 32,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: desable ? Colors.grey : Colors.blueAccent,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
