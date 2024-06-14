import 'package:auth_riverpod/providers/states/login_states.dart';
import 'package:auth_riverpod/repository/authRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) => LoginController(ref));
class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(LoginInitial());
  final  Ref ref;

  Future<void> login(String email, String password) async {
    state = LoginLoading();
    try {
      final result = await ref.read(authRepositoryProvider).login(email, password);
      state = LoginSuccess(result);
    } catch (e) {
      state = const LoginError('Failed to login');
    }
  }
}