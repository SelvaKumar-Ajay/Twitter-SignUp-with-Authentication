import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/utilitys.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authApi: ref.watch(authApiProvider),
        userApi: ref.watch(userApiProvider)));

final currentUserAccountProvider = FutureProvider(
  (ref) {
    return ref.watch(authControllerProvider.notifier).currentUser();
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;

  AuthController({
    required AuthApi authApi,
    required UserApi userApi,
  })  : _authApi = authApi,
        _userApi = userApi,
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
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNamefromEmail(email),
          profilePic: "",
          bannerPic: "",
          followers: const [],
          following: const [],
          uid: '',
          bio: '',
          isTwitterBlue: false);
      final res2 = await _userApi.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, textofAccountCreated);
        Navigator.push(context, LoginView.route());
      });
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
