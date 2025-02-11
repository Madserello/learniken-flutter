import 'dart:async';

class LoginService {
  static Future<bool> login(String email, String password) async {
    // Liten delay for å simulere et kall
    await Future.delayed(const Duration(seconds: 2));

    // Trenger bare at email og passord ikke er tom
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }
}
