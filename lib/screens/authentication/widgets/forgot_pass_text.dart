import 'package:fagopay/screens/authentication/forgot_password_screen.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassText extends StatelessWidget {
  const ForgotPassText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ),
          );
        },
        child: const Text(
          "Forgot password?",
          style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              color: signInPlaceholder,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline),
        ));
  }
}
