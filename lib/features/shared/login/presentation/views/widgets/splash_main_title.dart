import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class SplashMainTitle extends StatelessWidget {
  const SplashMainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(KImage.busPng, height: 100),
        SizedBox(height: KSizes.xl),
        Text(
          "WELCOME TO SAFE",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: KSizes.fonstSizexLg,
            color: KColors.splashFontColors,
            letterSpacing: 2.5,
          ),
        ),
        SizedBox(height: KSizes.sm),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: KColors.splashFontColors,
              fontSize: KSizes.fonstSizeSm,
            ),
            children: [
              TextSpan(text: "Built on "),
              TextSpan(
                text: "Trust",
                style: TextStyle(color: KColors.greenSecondary),
              ),
              TextSpan(text: ", Designed for "),
              TextSpan(
                text: "Safety",
                style: TextStyle(color: KColors.greenSecondary),
              ),
              TextSpan(text: "."),
            ],
          ),
        ),
      ],
    );
  }
}
