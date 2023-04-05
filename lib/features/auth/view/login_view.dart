import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';

import '../../../common reusable widgets/rounded_small_button.dart';
import '../../../theme/theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
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
                    controller: passwordController, hintText: textOfPassword),
                const SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SmallRoundButton(
                    label: textofDone,
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                RichText(
                    text: TextSpan(
                        text: textOfDontHaveAcc,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        children: [
                      TextSpan(
                        text: textOfSignUp,
                        style: const TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16.0,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
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
