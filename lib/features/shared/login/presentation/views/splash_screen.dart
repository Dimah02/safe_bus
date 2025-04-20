import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: KSpacingStyle.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(children: [Image.asset(KImage.busPng)]),
        ),
      ),
    );
  }
}
