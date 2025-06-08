import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/parent_home/student.dart';
import 'package:safe_bus/features/parent/dashboard/data/repo/absence_repository.dart';
import 'package:safe_bus/features/parent/dashboard/data/repo/parent_repository.dart';

part 'parent_home_state.dart';

class ParentHomeCubit extends Cubit<ParentHomeState> {
  ParentHomeCubit() : super(ParentHomeInitial());
  int _selectedStudentIndex = 0;
  List<Student>? _students = [];

  List<Student>? get students => _students;
  Student? get student => _students?[_selectedStudentIndex];
  int get index => _selectedStudentIndex;
  bool? get isAbsent => _students?[_selectedStudentIndex].isAbsent();

  Future<void> getParent() async {
    emit(ParentHomeLoading());
    try {
      _students = await ParentRepository.instance.getHomePage();
      emit(ParentHomeLoaded());
    } catch (e) {
      emit(ParentHomeError(e.toString()));
    }
  }

  void changeIndex({required int index}) {
    _selectedStudentIndex = index;
    emit(ParentHomeStudentSelected());
  }

  Future<void> updateStudentStatus({required int status}) async {
    try {
      for (var ride in students![index].rides!) {
        await AbsenceRepository.instance.updateStudentStatus(
          ridId: ride.rideId!,
          status: status,
        );
      }
      getParent();
    } catch (e) {}
  }
}
