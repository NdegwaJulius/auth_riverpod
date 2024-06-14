import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {

  Future<String> login(String email, String password) async {
    return Future.delayed(const Duration(seconds: 5)).then((value) => 'authToken');
  }

}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());