import 'package:flutter/material.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/core/utils/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const SafeApp());
}

class SafeApp extends StatelessWidget {
  const SafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sofia'),
    );
  }
}
