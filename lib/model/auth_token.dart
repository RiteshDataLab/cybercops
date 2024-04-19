
class AuthToken {
  static String? _jwtToken;

  static String? get jwtToken => _jwtToken;

  static void setToken(String token) {
    _jwtToken = token;
  }
}
