 import 'package:auth_riverpod/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final AuthService _authService;
  AuthRepository(this._authService);

  Future<String> login(String email, String password) async {
    return await _authService.login(email, password);
  }
}

final authRepositoryProvider =
 Provider<AuthRepository>((ref)
 => AuthRepository(ref.read(authServiceProvider),
 ),
 );