import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/driver_home.dart';
import 'package:safe_bus/features/driver/dashboard/data/repo/home_repo.dart';

part 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  DriverHomeCubit() : super(DriverHomeInitial());

  Future<void> getHome() async {
    emit(DriverHomeLoading());
    try {
      DriverHome home = await HomeRepo.instance.getHome();
      emit(DriverHomeSuccess(home: home));
    } catch (e) {
      emit(DriverHomeFailure(errMessage: e.toString()));
    }
  }
}
