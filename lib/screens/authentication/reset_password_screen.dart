import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {},
          color: fagoBlackColor,
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(
            color: fagoSecondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Work Sans',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(
              color: fagoSecondaryColor,
              backgroundColor: fagoSecondaryColorWithOpacity,
              minHeight: 1.75,
              value: 0.5,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Step 4 of 4',
                  style: TextStyle(
                    color: fagoBlackColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Setup Password',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Work Sans',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Provide a strong password to \nsecure your account',
              style: TextStyle(
                color: fagoBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const _PasswordInput(),
            const SizedBox(height: 10),
            const _ConfirmPasswordInput(),
            const SizedBox(height: 15),
            const _PasswordVerificationChips(),
            const SizedBox(height: 25),
            const _ContinueButton(),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: fagoSecondaryColor,
          fixedSize: const Size(200, 50),
        ),
        child: const Text('Continue'),
      ),
    );
  }
}

class _PasswordVerificationChips extends StatelessWidget {
  const _PasswordVerificationChips();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1,
      runSpacing: 2,
      children: const [
        Chip(
          label: Text(
            'At least 8 character strong',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'One lower case character',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'One upper case',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'A symbol or special character',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        focusColor: const Color(0XFFe8a5aa),
        hintText: 'Password',
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        prefixIconColor: const Color(0XFFe8a5aa),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFFe8a5aa),
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        prefixIcon: SvgPicture.asset(
          'assets/icons/lock-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        focusColor: const Color(0XFFe8a5aa),
        hintText: 'Confirm Password',
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        prefixIconColor: const Color(0XFFe8a5aa),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFFe8a5aa),
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        prefixIcon: SvgPicture.asset(
          'assets/icons/lock-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
        suffixIcon: SvgPicture.asset(
          'assets/icons/show-password-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
