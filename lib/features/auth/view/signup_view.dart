import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import '../../../common reusable widgets/export_reusable_widgets.dart';
import '../../../common reusable widgets/loadingpage.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        passWord: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const LoaderIndicator()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      AuthReusableTextField(
                          controller: emailController, hintText: textOfEmail),
                      const SizedBox(
                        height: 25.0,
                      ),
                      AuthReusableTextField(
                          controller: passwordController,
                          hintText: textOfPassword),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SmallRoundButton(
                          label: textofDone,
                          onTap: onSignUp,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      RichText(
                          text: TextSpan(
                              text: textOfAlreadyHaveAcc,
                              style: const TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 16.0,
                              ),
                              children: [
                            TextSpan(
                              text: textOfLogin,
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, LoginView.route());
                                },
                            )
                          ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
