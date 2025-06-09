import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/parent/map/data/models/student_route/student_route.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

class StudentRouteRepo {
  static final StudentRouteRepo instance = StudentRouteRepo._();
  StudentRouteRepo._();

  Future<List<StudentRoute>> getStudentRoute() async {
    final userId = await LoginRepo.instance.getID();

    final data = await KHTTP.instance.get(
      endpoint: 'parents/StudentsWithRoutes/$userId',
    );
    List<StudentRoute> students = [];
    for (var student in data) {
      students.add(StudentRoute.fromJson(student));
    }

    return students;
  }
}
