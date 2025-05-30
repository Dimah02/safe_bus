import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/driver/map/data/repo/trip_students_repo.dart';

part 'trip_students_state.dart';

class TripStudentsCubit extends Cubit<TripStudentsState> {
  TripStudentsCubit() : super(TripStudentsInitial());

  Future<void> getStudents({required int busRouteId}) async {
    emit(TripStudentsLoading());
    try {
      List<StudentModel> students = await TripStudentsRepo.instance.getStudents(
        busRouteId: busRouteId,
      );
      emit(TripStudentsSuccess(students: students));
    } catch (e) {
      emit(TripStudentsFailure(errMessage: e.toString()));
    }
  }
}
