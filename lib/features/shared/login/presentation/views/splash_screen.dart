import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/role_container.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/splash_main_title.dart';

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
              SplashMainTitle(),
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
