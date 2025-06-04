import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/teacher_home.dart';

class HomeRepo {
  static final HomeRepo instance = HomeRepo._constructor();
  HomeRepo._constructor();

  Future<TeacherHome> getHome() async {
    try {
      String? usreID = await LoginRepo.instance.getID();
      int id = int.parse(usreID!);
      var data = await KHTTP.instance.get(endpoint: "BusRoutes/Home/$id");
      TeacherHome homeData = TeacherHome.fromJson(data);

      return homeData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
