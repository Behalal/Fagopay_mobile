// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/screens/authentication/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/colors.dart';

class RecoverPasswordOTPScreen extends StatefulWidget {
  final String email;

  const RecoverPasswordOTPScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<RecoverPasswordOTPScreen> createState() =>
      _RecoverPasswordOTPScreenState();
}

class _RecoverPasswordOTPScreenState extends State<RecoverPasswordOTPScreen> {
  final TextEditingController _pinController = TextEditingController();

  // @override
  // void dispose() {
  //   _pinController.clear();
  //   super.dispose();
  // }

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
          onPressed: () => Navigator.of(context).pop(),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(
              color: fagoSecondaryColor,
              backgroundColor: fagoSecondaryColorWithOpacity,
              minHeight: 1.75,
              value: 0.25,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Step 2 of 4',
                  style: TextStyle(
                    color: fagoBlackColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Provide OTP',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Work Sans',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'We sent OTP to ${widget.email}. Please check your inbox and enter the OTP received.',
              style: const TextStyle(
                color: fagoBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kindly input the code below',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            PinCodeTextField(
              controller: _pinController,
              appContext: context,
              length: 6,
              onChanged: (value) {
                if (value.length == 6) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(pinCode: value),
                    ),
                  );
                }
              },
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldHeight: 45,
                fieldWidth: 45,
                activeFillColor: Colors.white,
              ),
            ),
            // const SizedBox(height: 5),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Didn\'t recieve an otp?',
                    style: TextStyle(
                      color: fagoSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                const Icon(
                  Icons.refresh,
                  size: 15,
                  color: fagoSecondaryColor,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                      color: fagoSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
