import 'package:get/get.dart';
import 'package:safe_bus/core/utils/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
