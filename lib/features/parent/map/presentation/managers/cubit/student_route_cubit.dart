import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/parent/map/data/models/student_route/ride.dart';
import 'package:safe_bus/features/parent/map/data/models/student_route/student_route.dart';
import 'package:safe_bus/features/parent/map/data/repo/student_route_repository.dart';

part 'student_route_state.dart';

class StudentRouteCubit extends Cubit<StudentRouteState> {
  StudentRouteCubit() : super(StudentRouteInitial());
  List<StudentRoute> students = [];
  StudentRoute? student;
  Ride? ride;
  Future<void> getStudentRoute({
    required int studentId,
    required bool isMorning,
  }) async {
    emit(StudentRouteLoading());
    try {
      students = await StudentRouteRepo.instance.getStudentRoute();
      for (var s in students) {
        if (s.studentId == studentId) {
          student = s;
          if (isMorning) {
            ride = s.morningRoute();
          } else {
            ride = s.afternoonRoute();
          }
        }
      }
      emit(StudentRouteSuccess());
    } catch (e) {
      emit(StudentRouteFailure(errorMessage: e.toString()));
    }
  }
}
