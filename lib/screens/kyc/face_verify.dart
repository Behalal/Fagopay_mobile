import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../authentication/account_creation/widgets/current_step.dart';
import '../authentication/widgets/auth_buttons.dart';
import '../constants/colors.dart';
import 'kyc2.dart';
import 'kyc_details.dart';

class FaceVerify extends StatefulWidget {
  const FaceVerify({super.key});

  @override
  State<FaceVerify> createState() => FaceVerifystate();
}

class FaceVerifystate extends State<FaceVerify> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentStep(step: "2", backRoute: const BvnVerification()),
                SizedBox(
                  height: 6.h,
                ),
                const Text(
                  "Please ensure that your eyes and ears are centered in the circle shape ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/Ellipse 45.png"),
                      ),
                      CircleAvatar(
                        radius: 110,
                        backgroundImage: AssetImage("assets/images/fago(2).png"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                  child: AuthButtons(
                    form: false,
                    hasImage: "assets/images/camera.png",
                    text: "Retake Selfie",
                    route: const KycDetailsScreen(),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                  child: AuthButtons(
                    form: false,
                    text: "Continue",
                    route: const KycDetailsScreen(),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const BvnVerification()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Cannot verify facial?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      ),
                      Text(
                        "Use another method",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      )),
    );
  }
}
