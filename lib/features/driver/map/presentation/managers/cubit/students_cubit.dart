import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/driver/map/data/repo/trip_students_repo.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit({required this.busRouteId}) : super(StudentsLoading()) {
    _loadStudents();
  }

  final int busRouteId;
  String? zoneName = "";
  String? busId;
  List<StudentModel> _students = [];

  List<StudentModel> get students => _students;

  Future<void> _loadStudents() async {
    try {
      _students = await TripStudentsRepo.instance.getStudents(
        busRouteId: busRouteId,
      );

      // Extract additional info if available
      if (_students.isNotEmpty) {}

      emit(StudentsLoaded(_students));
    } catch (e) {
      emit(StudentsError('Failed to load students: $e'));
    }
  }

  Future<void> refresh() => _loadStudents();
}
