import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import '../../../common reusable widgets/export_reusable_widgets.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
