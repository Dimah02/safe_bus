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

  Future<void> updateBusInfo(
    int busId,
    int busRouteId,
    double lat,
    double lon,
  ) async {
    try {
      await KHTTP.instance.put(
        endpoint: "buses/updatelocation/$busId",
        body: {'BusRouteId': busRouteId, 'latitude': lat, 'longitude': lon},
      );
    } catch (e) {
      print('Error updating bus: $e');
    }
  }

  Future<void> completedTrip(int busRouteId) async {
    try {
      await KHTTP.instance.get(
        endpoint: "CompletedTrips/CompleteTrip/$busRouteId",
      );
    } catch (e) {
      print('Error updating bus: $e');
    }
  }
}
