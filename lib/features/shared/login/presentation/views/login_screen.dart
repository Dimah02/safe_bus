import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/spacing_style.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final Map<String, dynamic>? extraData;

  LoginScreen({super.key, this.extraData});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String selectedRole = extraData?['selectedRole'] ?? 'Unknown';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: KColors.white),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _navigateToRolePage(context, selectedRole);
          } else if (state is AuthFailure) {
            Toast(
              context,
            ).showToast(message: state.errMessage, color: KColors.fadedRed);
            print(state.errMessage);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
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
                        Text(
                          "Logging in as $selectedRole",
                          style: TextStyle(
                            color: KColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: KSizes.defaultSpace),

                        TextFormField(
                          enabled: (state is AuthLoading) ? false : true,
                          controller: _email,
                          cursorColor: KColors.textFieldHintColor,
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(height: KSizes.defaultSpace),
                        TextFormField(
                          enabled: (state is AuthLoading) ? false : true,
                          controller: _password,
                          obscureText: true,
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
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).signIn(
                                  email: _email.text,
                                  password: _password.text,
                                  userType: _getUserRole(selectedRole),
                                );
                              }
                            },
                            child:
                                state is AuthLoading
                                    ? CircularProgressIndicator(
                                      color: KColors.greenAccent,
                                    )
                                    : Text(
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
                              TextSpan(
                                text: "By Logging in, you agree to the ",
                              ),
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
          );
        },
      ),
    );
  }

  void _navigateToRolePage(BuildContext context, String role) {
    switch (role.toLowerCase()) {
      case 'parent':
        GoRouter.of(context).push(AppRouter.parentDashboard);
        break;
      case 'teacher':
        GoRouter.of(context).push(AppRouter.teacherDashboard);
        break;
      case 'driver':
        GoRouter.of(context).push(AppRouter.driverDashboard);
        break;
      case 'admin':
        GoRouter.of(context).push(AppRouter.teacherDashboard);
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unknown role: $role')));
    }
  }

  int _getUserRole(String role) {
    switch (role.toLowerCase()) {
      case "user":
        return 0;
      case "admin":
        return 1;
      case "driver":
        return 2;
      case "teacher":
        return 3;
      case "parent":
        return 4;
      default:
        return 5;
    }
  }
}
