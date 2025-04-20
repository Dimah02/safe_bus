import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/role_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: KSpacingStyle.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: KSizes.xxl),
              Text(
                "I am a",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: KSizes.fonstSizexLg,
                  color: KColors.splashFontColors,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(height: KSizes.sm),
              Text(
                "Select one that applies to you",
                style: TextStyle(
                  color: KColors.splashFontColors,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
              SizedBox(height: KSizes.xxxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoleContainer(
                    name: "Parent",
                    image: KImage.parentImage,
                    bgColor: KColors.greenAccent,
                  ),
                  RoleContainer(
                    name: "Teacher",
                    image: KImage.teacherImg,
                    bgColor: KColors.purpleAccent,
                  ),
                ],
              ),
              SizedBox(height: KSizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoleContainer(
                    name: "Driver",
                    image: KImage.driverImage,
                    bgColor: KColors.orangeAccent,
                  ),
                  RoleContainer(
                    name: "Admin",
                    image: KImage.adminImage,
                    bgColor: KColors.bluePrimay,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
