import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/teacher/Home/data/repo/home_repo.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/teacher_home.dart';

part 'teacher_home_state.dart';

class TeacherHomeCubit extends Cubit<TeacherHomeState> {
  TeacherHomeCubit() : super(TeacherHomeInitial());

  Future<void> getHome() async {
    emit(TeacherHomeLoading());
    try {
      TeacherHome home = await HomeRepo.instance.getHome();
      emit(TeacherHomeSuccess(home: home));
    } catch (e) {
      emit(TeacherHomeFailure(errMessage: e.toString()));
    }
  }
}
