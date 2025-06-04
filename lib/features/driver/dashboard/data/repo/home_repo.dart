import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/driver_home.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

class HomeRepo {
  static final HomeRepo instance = HomeRepo._constructor();
  HomeRepo._constructor();

  Future<DriverHome> getHome() async {
    try {
      String? usreID = await LoginRepo.instance.getID();
      int id = int.parse(usreID!);
      var data = await KHTTP.instance.get(endpoint: "BusRoutes/Home/$id");
      DriverHome homeData = DriverHome.fromJson(data);

      return homeData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
