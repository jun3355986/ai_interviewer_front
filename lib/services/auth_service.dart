import '../models/user.dart';
import '../api/user_api.dart';
import '../api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final AuthApi _authApi;
  final UserApi _userApi;

  AuthService(this._authApi, this._userApi);

  Future<LoginResponse?> login(String username, String password) async {
    try {
      final response = await _authApi.login(username, password);
      if (response.statusCode == 200 && response.data['code'] == 0) {
        final loginData = LoginResponse.fromJson(response.data['data']);
        await _saveTokens(loginData.accessToken, loginData.refreshToken);
        return loginData;
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

  Future<bool> register(
    String username,
    String password,
    String email,
    String nickname,
  ) async {
    try {
      final response = await _authApi.register({
        'username': username,
        'password': password,
        'confirmPassword': password,
        'email': email,
        'nickname': nickname,
      });
      return response.statusCode == 200 && response.data['code'] == 0;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
    }
  }

  Future<User?> getMe() async {
    try {
      final response = await _userApi.getMe();
      if (response.statusCode == 200 && response.data['code'] == 0) {
        return User.fromJson(response.data['data']);
      }
    } catch (e) {
      print('GetMe error: $e');
    }
    return null;
  }

  Future<void> _saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', access);
    await prefs.setString('refreshToken', refresh);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') != null;
  }
}
