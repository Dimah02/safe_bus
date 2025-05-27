import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/driver/map/data/repo/student_attendance_repo.dart';

part 'trip_students_state.dart';

class TripStudentsCubit extends Cubit<TripStudentsState> {
  TripStudentsCubit() : super(TripStudentsInitial());
  int totalStudents = 0;

  Future<void> getStudentsAttendance({required int busRouteId}) async {
    emit(TripStudentsLoading());
    try {
      List<StudentModel> students = await TripStudentsRepo.instance.getStudents(
        busRouteId: busRouteId,
      );
      totalStudents = students.length;
      emit(TripStudentsSuccess());
    } catch (e) {
      emit(TripStudentsFailure(errMessage: e.toString()));
    }
  }
}
