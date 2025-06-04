import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/parent_home/student.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

class ParentRepository {
  static final ParentRepository instance = ParentRepository._();
  ParentRepository._();

  Future<List<Student>> getHomePage() async {
    final userId = await LoginRepo.instance.getID();

    final data = await KHTTP.instance.get(
      endpoint: 'parents/$userId/students-with-bus-routes',
    );
    List<Student> students = [];
    for (var student in data) {
      students.add(Student.fromJson(student));
    }

    return students;
  }
}
