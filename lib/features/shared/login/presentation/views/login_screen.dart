import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: KSpacingStyle.paddingNoTop,
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Image.asset(KImage.schoolImage),
                Text("Email"),
                TextFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
