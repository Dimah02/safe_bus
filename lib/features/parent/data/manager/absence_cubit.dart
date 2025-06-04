import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/parent/data/models/absences_model.dart';
import 'package:safe_bus/features/parent/data/repo/absence_repository.dart';

part 'absence_state.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  final AbsenceRepository absenceRepository;

  AbsenceCubit(this.absenceRepository) : super(AbsenceInitial());

  Future<Absences?> reportAbsence(int studentId) async {
    emit(AbsenceInitial());
    try {
      final reportedAbsence = await absenceRepository.postAbsence(studentId);
      emit(AbsenceSent());
      return reportedAbsence;
    } catch (e) {
      emit(AbsenceError(e.toString()));
      return null;
    }
  }

  Future<void> deleteAbsence(int absenceId) async {
    emit(AbsenceInitial());
    try {
      await absenceRepository.deleteAbsence(absenceId);
      emit(AbsenceDeleted(absenceId));
    } catch (e) {
      emit(AbsenceError(e.toString()));
    }
  }
}