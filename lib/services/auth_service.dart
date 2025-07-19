import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 3));

    if (email.isNotEmpty && password.isNotEmpty) {
      await _storage.write(key: 'userEmail', value: email);
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password) async {
    await Future.delayed(Duration(seconds: 3));

    if (email.isNotEmpty && password.isNotEmpty) {
      await _storage.write(key: 'userEmail', value: email);
      return true;
    }
    return false;
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: 'userEmail');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}