import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_bus/core/theme/theme.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/core/utils/service_locator.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';

void main() async {
  //await dotenv.load(fileName: ".env");
  setupServiceLocator();
  runApp(const SafeApp());
}

class SafeApp extends StatelessWidget {
  const SafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        builder: FToastBuilder(),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: KAppTheme.lighTheme,
      ),
    );
  }
}
