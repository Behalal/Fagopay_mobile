import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFffffff),
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -20,
            child: Image.asset(
              'assets/images/rectange-design.jpg',
              height: 350,
              width: 300,
            ),
          ),
          Positioned(
            top: 75,
            left: 20,
            child: SvgPicture.asset(
              'assets/icons/fago-frame.svg',
            ),
          ),
          Positioned(
            left: 10.w,
            top: 35.h,
            child: const Text(
              'Forgot Password',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Work Sans',
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            top: 41.h,
            child: const Text(
              'Recover lost Password',
              style: TextStyle(
                color: fagoBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                // fontFamily: 'Work Sans',
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 10.w,
            child: SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  focusColor: const Color(0XFFe8a5aa),
                  hintText: 'Phone number or Email',
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
                    'assets/icons/dial-icon.svg',
                    fit: BoxFit.scaleDown,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25.h,
            left: 15.w,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: fagoSecondaryColor,
                  fixedSize: const Size(250, 50),
                ),
                child: const Text('Submit'),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 36.w,
            child: GestureDetector(
              onTap: () {},
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Back to ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: fagoSecondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
