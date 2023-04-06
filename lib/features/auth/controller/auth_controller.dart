import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/utilitys.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(authApi: ref.watch(authApiProvider)));

final currentUserAccountProvider = FutureProvider(
  (ref) {
    return ref.watch(authControllerProvider.notifier).currentUser();
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  Future<model.Account?> currentUser() => _authApi.getCurrentUserAccount();

  void signUp({
    required String email,
    required String passWord,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, passWord: passWord);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, textofAccountCreated);
      Navigator.push(context, LoginView.route());
    });
  }

  void logIn({
    required String email,
    required String passWord,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.logIn(email: email, passWord: passWord);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, textofLoginSuccessful);
      Navigator.push(context, HomeView.route());
    });
  }
}
