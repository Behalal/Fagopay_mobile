import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../forgot_password_screen.dart';

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
