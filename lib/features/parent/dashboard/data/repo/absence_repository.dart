import 'package:safe_bus/core/utils/http_client.dart';

class AbsenceRepository {
  static final AbsenceRepository instance = AbsenceRepository._();
  AbsenceRepository._();

  Future<void> updateStudentStatus({
    required int ridId,
    required int status,
  }) async {
    try {
      await KHTTP.instance.patch(
        endpoint: "Rides/UpdateStatus/$ridId?status=$status",
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
