import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utilitys.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(authApi: ref.watch(authApiProvider)));

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  void signUp({
    required String email,
    required String passWord,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, passWord: passWord);
    state = false;
    res.fold(
        (l) => showSnackBar(context, l.message), (r) => debugPrint(r.email));
  }
}
