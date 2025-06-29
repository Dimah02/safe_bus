import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/features/shared/login/data/models/user_model.dart';
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late UserModel user;

  Future<void> signIn({
    required String email,
    required String password,
    required int userType,
  }) async {
    emit(AuthLoading());
    try {
      user = await LoginRepo.instance.signIn(
        email: email,
        password: password,
        userType: userType,
      );
      emit(AuthSuccess());
    } catch (e) {
      print(e.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  void logout() {
    // await SecureStorage.clear();
    // SharedPreferences.remove('token');
    
    user = UserModel();
    emit(AuthInitial());
  }
}
