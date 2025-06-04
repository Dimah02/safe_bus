import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/parent/data/models/absences_model.dart';

class AbsenceRepository {
  static final AbsenceRepository instance = AbsenceRepository._();
  AbsenceRepository._();

  Future<Absences> postAbsence(int studentId) async {
    try {
    final response = await KHTTP.instance.post(
      endpoint: 'absences/report',
      body: {"studentId": studentId},
    );
    print('API response: $response');
    return Absences.fromJson(response);
  } catch (e) {
    print('postAbsence error: $e');
    rethrow;
  }
  }

  Future<void> deleteAbsence(int absenceId) async {
    await KHTTP.instance.delete(
      endpoint: 'absences/$absenceId',
    );
  }
}
