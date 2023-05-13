import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../authentication/account_creation/select_type.dart';
import '../authentication/sign_in.dart';
import '../authentication/widgets/auth_buttons.dart';
import '../constants/colors.dart';
import 'content_model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: 100.w,
              height: 0.h,
              child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, i) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.2.w, vertical: 1.h),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: 60.h,
                              child: Image.asset(
                                contents[i].image!,
                                fit: BoxFit.fitWidth,
                                // width: 334,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: 80.w,
                              child: Text(
                                contents[i].title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: AutoSizeText(
                                contents[i].discription!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ));
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
            child: GestureDetector(
              onTap: () {
                //? Show login screen
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool('showLogin', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const SelectVerificationType(),
                  ),
                );

                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => const SelectType(),
                //   ),
                // );
              },
              child: AuthButtons(
                form: false,
                text: "Get Started",
                route: const SelectVerificationType(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    color: signInPlaceholder,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SignIn(),
                      ),
                    );
                  }),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      color: buttonColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 18 : 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? fagoSecondaryColor
            : fagoSecondaryColorWithOpacity,
      ),
    );
  }
}
