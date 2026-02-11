import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  AuthUtils._internal();
  static final AuthUtils instance = AuthUtils._internal();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _isLoggedInKey = 'is_logged_in';

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, accessToken);

    if (refreshToken != null) {
      await prefs.setString(_refreshTokenKey, refreshToken);
    }

    await prefs.setBool(_isLoggedInKey, true);
  }

  Future<String?> get readAccessToken async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> get readRefreshToken async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<bool> get isLoggedIn async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}
