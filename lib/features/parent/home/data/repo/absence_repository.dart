import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/parent/home/data/models/absences_model.dart';

class AbsenceRepository {
  static final AbsenceRepository instance = AbsenceRepository._();
  AbsenceRepository._();

  Future<Absences> postAbsence(Absences absence) async {
    final response = await KHTTP.instance.post(
      endpoint: 'absences',
      body: absence.toJson(),
    );
    return Absences.fromJson(response);
  }

  Future<void> deleteAbsence(int absenceId) async {
    await KHTTP.instance.delete(endpoint: 'absences/$absenceId');
  }
}
