import 'package:flutter/material.dart';
import 'package:safe_bus/features/driver/map/presentation/widgets/custom_google_map.dart';

class DriverMapScreen extends StatelessWidget {
  const DriverMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomGoogleMap());
  }
}
