import 'package:auto_size_text/auto_size_text.dart';
import '../authentication/sign_in.dart';
import '../authentication/widgets/auth_buttons.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class kyc_success extends StatelessWidget {
  const kyc_success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
                child: const AutoSizeText(
                  "KYC Successful",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Text(
                "Hello Ibrahim! Congratulations ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Text(
                "You can now enjoy more services and we encourage you to upgrade to a higher Tier to access more of our product offers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  Positioned(
                    child: Image(image: AssetImage("assets/images/Group.png")),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: SizedBox(
                  width: 70.w,
                  child: const AutoSizeText(
                    "You will be directed in 10s",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: inactiveTab,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
