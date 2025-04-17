import 'package:get_it/get_it.dart';
import 'package:safe_bus/core/utils/http_client.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<KHTTP>(KHTTP());
}
