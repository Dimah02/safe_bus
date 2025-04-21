import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
                  color: KColors.greenSecondary,
                  image: DecorationImage(
                    alignment: Alignment(0, 1),
                    fit: BoxFit.fitWidth,
                    image: AssetImage(KImage.schoolImage),
                  ),
                ),
              ),
              Padding(
                padding: KSpacingStyle.paddingNoTop,
                child: Column(
                  children: [
                    SizedBox(height: KSizes.spaceBtwSections),
                    TextFormField(
                      cursorColor: KColors.textFieldHintColor,
                      decoration: InputDecoration(label: Text("Email")),
                    ),
                    SizedBox(height: KSizes.defaultSpace),
                    TextFormField(
                      cursorColor: KColors.textFieldHintColor,
                      decoration: InputDecoration(label: Text("Password")),
                    ),
                    SizedBox(height: KSizes.defaultSpace),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(width: KSizes.xs),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: KColors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: KColors.greenSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(color: KColors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: KSizes.spaceBtwSections),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: KColors.grey,
                          fontSize: KSizes.fonstSizexSm,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(text: "By Logging in, you agree to the "),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: KColors.fontColor),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Data Processing Agreement",
                            style: TextStyle(color: KColors.fontColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
