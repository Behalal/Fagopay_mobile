import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RecoverPasswordOTPScreen extends StatelessWidget {
  const RecoverPasswordOTPScreen({super.key});

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
            const Text(
              'We sent OTP to obasa@fagopay.com. Please check your inbox and enter the OTP received.',
              style: TextStyle(
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
              appContext: context,
              length: 4,
              onChanged: (value) {},
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
            )
          ],
        ),
      ),
    );
  }
}
