import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/registration_controller.dart';
import 'package:get/get.dart';
import '../sign_in.dart';
import '../widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SuccessAccountCreation extends StatefulWidget {
  const SuccessAccountCreation({super.key});

  @override
  State<SuccessAccountCreation> createState() => _SuccessAccountCreationState();
}

class _SuccessAccountCreationState extends State<SuccessAccountCreation> {
  final _registrationController = Get.find<RegistrationController>();

  @override
  void dispose() {
    _registrationController.firstname.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
                child: const AutoSizeText(
                  "Account Created",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.h),
                child: SizedBox(
                  width: 50.w,
                  child: const AutoSizeText(
                    "Successfully",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  Positioned(
                    child:
                        Image(image: AssetImage("assets/images/bg_image.png")),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: SizedBox(
                  width: 50.w,
                  child: AutoSizeText(
                    "Hello ${_registrationController.firstname.text}!",
                    style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: inactiveTab,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: SizedBox(
                  width: 70.w,
                  child: const AutoSizeText(
                    "Welcome Onboard",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: inactiveTab,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SizedBox(
                  width: 70.w,
                  child: const AutoSizeText(
                    "Passcode is a tier-2 security level to help verify your identity after leaving the app for a while.",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: successDescription,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.w, bottom: 3.h, top: 3.h, right: 2.w),
                child: AuthButtons(
                    form: false,
                    text: "Login to continue",
                    route: const SignIn()),
              )
            ],
          ),
        ),
      )),
    );
  }
}
