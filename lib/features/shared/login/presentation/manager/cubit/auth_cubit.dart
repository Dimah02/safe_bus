import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/features/shared/login/data/models/user_model.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late UserModel user;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      user = await LoginRepo.instance.signIn(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
