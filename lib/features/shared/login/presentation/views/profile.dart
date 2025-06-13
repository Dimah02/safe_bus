import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:app_settings/app_settings.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/profile_fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().user;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.go(AppRouter.splash);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  //Header
                  Container(
                    color: KColors.greenAccent,
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: KSizes.defaultSpace,
                          bottom: -40,
                          child: Row(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: SvgPicture.asset(
                                        KImage.parentImage,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 0,
                                  //   right: 0,
                                  //   child: CircleAvatar(
                                  //     radius: 14,
                                  //     backgroundColor: KColors.strokColor,
                                  //     child: Icon(
                                  //       Icons.edit,
                                  //       size: KSizes.iconSm,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(width: KSizes.spaceBtwItems),
                              Text(
                                user.name ?? "",
                                style: TextStyle(
                                  fontSize: KSizes.fonstSizexLg,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Profile Items
                  SizedBox(height: 70),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: KSizes.defaultSpace,
                      ),
                      child: Column(
                        children: [
                          ProfileOption(
                            icon: Icons.home_work_outlined,
                            iconColor: Colors.green,
                            text: _getUserRole(user.userType),
                            onTap: null,
                          ),
                          Divider(),
                          ProfileOption(
                            icon: Icons.mail_outline,
                            iconColor: Colors.purple,
                            text: user.email.toString(),
                            onTap: null,
                          ),
                          Divider(),
                          ProfileOption(
                            icon: Icons.phone_outlined,
                            iconColor: Colors.orange,
                            text: user.phoneNo.toString(),
                            onTap: null,
                          ),
                          Divider(),
                          ProfileOption(
                            icon: Icons.notifications_outlined,
                            iconColor: Colors.blue,
                            text: "Notifications",
                            trailing: Text(
                              "ON/OFF",
                              style: TextStyle(
                                color: KColors.fontBlue,
                                fontSize: KSizes.fonstSizeLg,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onTap: () {
                              AppSettings.openAppSettings();
                            },
                          ),

                          //Logout Button
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                              },
                              child: Text("Logout"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: BottomNavBar(
                    currentIndex: _currentIndex,
                    userType: context.read<AuthCubit>().user.userType ?? 0,
                    onTap: (index) {
                      setState(() => _currentIndex = index);
                      if (index == 0) {
                        final userType =
                            context.read<AuthCubit>().user.userType;
                        switch (userType) {
                          case 2: //Driver
                            context.go(AppRouter.driverDashboard);
                            break;
                          case 3: //Teacher
                            context.go(AppRouter.teacherDashboard);
                            break;
                          case 4: //Parent
                            context.go(AppRouter.parentDashboard);
                            break;
                          default:
                            context.go(AppRouter.splash);
                            Toast(context).showToast(
                              message: "UNdefined role.",
                              color: KColors.fadedRed,
                            );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getUserRole(int? userType) {
    switch (userType) {
      case 2:
        return "Driver";
      case 3:
        return "Assistant Teacher";
      case 4:
        return "Parent";
      default:
        return "Unknown";
    }
  }
}
