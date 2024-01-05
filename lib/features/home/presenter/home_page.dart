import 'package:app_design/app_images.dart';
import 'package:app_design/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AppImageWidget(
              image: AppImage.logo,
              size: Size(300, 300),
            ),
          ),
        ],
      ),
    );
  }
}
