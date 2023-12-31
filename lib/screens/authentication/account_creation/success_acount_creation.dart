import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/route_replacement_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/registration_controller.dart';
import '../../constants/colors.dart';
import '../sign_in.dart';

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
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    "Welcome Onboard",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    color: fagoSecondaryColorWithOpacity10,
                    height: 45.h,
                    width: Get.width,
                    child: const Stack(alignment: Alignment.bottomCenter, children: [
                      Image(image: AssetImage("assets/images/iPhone 14 Pro Space Black Mockup.png"), height: 300, width: 300,),
                    ]),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 15.w),
                  //   child: SizedBox(
                  //     width: 50.w,
                  //     child: AutoSizeText(
                  //       "Hello ${_registrationController.firstname.text}!",
                  //       style: const TextStyle(
                  //         fontFamily: "Work Sans",
                  //         fontSize: 22,
                  //         fontWeight: FontWeight.w700,
                  //         color: inactiveTab,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 4.h,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 22.w),
                  //   child: SizedBox(
                  //     width: 70.w,
                  //     child: const AutoSizeText(
                  //       "Welcome Onboard",
                  //       style: TextStyle(
                  //         fontFamily: "Work Sans",
                  //         fontSize: 22,
                  //         fontWeight: FontWeight.w700,
                  //         color: inactiveTab,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                    child: const AutoSizeText(
                      "We are glad to have you onboard. \nPlease kindly proceed to login and enjoy our smooth \nbanking services and financial management tools..",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: stepsColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 4.w, bottom: 3.h, top: 3.h, right: 2.w),
                    child: RouteReplacementButton(
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
