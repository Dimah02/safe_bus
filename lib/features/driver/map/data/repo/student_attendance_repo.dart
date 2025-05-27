import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';

class TripStudentsRepo {
  static final TripStudentsRepo instance = TripStudentsRepo._constructor();
  TripStudentsRepo._constructor();

  Future<List<StudentModel>> getStudents({required int busRouteId}) async {
    try {
      var data = await KHTTP.instance.get(
        endpoint: "BusRoutes/currentStudents/$busRouteId",
      );
      List<StudentModel> studnets = [];
      for (var student in data) {
        studnets.add(StudentModel.fromJson(student));
      }
      return studnets;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
