import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_bus/core/theme/theme.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:safe_bus/firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

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
