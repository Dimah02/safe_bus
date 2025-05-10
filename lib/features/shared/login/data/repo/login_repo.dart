import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_bus/core/utils/http_client.dart';
import 'package:safe_bus/features/shared/login/data/models/user_model.dart';

class LoginRepo {
  static final LoginRepo instance = LoginRepo._constructor();
  LoginRepo._constructor();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> storeID(String id) async {
    await _storage.write(key: 'id', value: id);
  }

  Future<String?> getID() async {
    return await _storage.read(key: 'id');
  }

  Future<void> storeRole(String role) async {
    await _storage.write(key: 'role', value: role);
  }

  Future<String?> getRole() async {
    return await _storage.read(key: 'role');
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
    required int userType,
  }) async {
    try {
      var data = await KHTTP.instance.post(
        endpoint: "Auth/login",
        body: {"email": email, "password": password, "userType": userType},
      );
      await storeToken(data["accessToken"]);
      await storeID(data["user"]["userId"].toString());
      await storeRole(_getUserRole(data["user"]["userType"]));
      UserModel user = UserModel.fromJson(data);
      return user;
    } catch (e) {
      if (e.toString().contains("Invalid credentials")) {
        throw Exception("Invalid credentials");
      }
      throw Exception(e.toString());
    }
  }

  String _getUserRole(int type) {
    switch (type) {
      case 0:
        return "user";
      case 1:
        return "admin";
      case 2:
        return "driver";
      case 3:
        return "teacher";
      case 4:
        return "parent";
      default:
        return "Unknown";
    }
  }
}
