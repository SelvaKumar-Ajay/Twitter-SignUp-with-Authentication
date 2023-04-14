import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
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

final currentUserDetailsProvider = FutureProvider(
  (ref) {
    final currentUserID =
        // ref.watch(currentUserAccountProvider).asData.toString();
        ref.watch(currentUserAccountProvider).value!.$id;
    debugPrint("currentUserID $currentUserID");
    final userDetails = ref.watch(userDetailsProvider(currentUserID));
    debugPrint("userDetails $userDetails.toString()");
    return userDetails.value;
  },
);

final userDetailsProvider = FutureProvider.family(
  (ref, String uid) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.getUserData(uid);
  },
);

final currentUserAccountProvider = FutureProvider(
  (ref) {
    final authController =
        ref.watch(authControllerProvider.notifier).currentUser();
    return authController;
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
          uid: r.$id,
          bio: "",
          isTwitterBlue: false);
      debugPrint("signup $r.$id");
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

  Future<UserModel> getUserData(String uid) async {
    final document = await _userApi.getUserData(uid);
    final updateUser = UserModel.fromMap(document.data);
    return updateUser;
  }
}
