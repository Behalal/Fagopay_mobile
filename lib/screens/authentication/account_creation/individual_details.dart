import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/registration_controller.dart';
import 'package:get/get.dart';
import '../../../functions/functions.dart';
import 'select_verification_type.dart';
import 'setup_password.dart';
import 'widgets/current_step.dart';
import 'widgets/user_details.dart';
import '../widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IndividualDetails extends StatefulWidget {
  const IndividualDetails({super.key});

  @override
  State<IndividualDetails> createState() => _IndividualDetailsState();
}

class _IndividualDetailsState extends State<IndividualDetails> {
  bool isLoading = false;
  Functions function = Functions();
  final _registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentStep(
                    step: "3", backRoute: const SelectVerificationType()),
                SizedBox(height: 5.h),
                Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: const AutoSizeText(
                      "Individual Details",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: fagoSecondaryColor,
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                    width: 80.w,
                    child: const AutoSizeText(
                      "Kindly ensure this details is accurate as it would be used for verification.",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: inactiveTab,
                      ),
                    ),
                  ),
                ),
                UserData(
                  firstname: _registrationController.firstname,
                  lastname: _registrationController.lastname,
                  email: _registrationController.email,
                  referrer: _registrationController.referral,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: GestureDetector(
                    onTap: () {
                      if (_registrationController.firstname.text.isEmpty ||
                          _registrationController.lastname.text.isEmpty ||
                          _registrationController.email.text.isEmpty) {
                        // SweetAlertV2.show(context,
                        //     title: "Kindly Insert all fields",
                        //     style: SweetAlertV2Style.error,
                        //     titleStyle: const TextStyle(
                        //       fontFamily: "Work Sans",
                        //       fontSize: 10,
                        //       fontWeight: FontWeight.w400,
                        //     ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Kindly Insert all fields',
                            ),
                          ),
                        );
                      } else if (!function
                          .validateEmail(_registrationController.email.text)) {
                        // SweetAlertV2.show(context,
                        //     title: "Invalid email address sent",
                        //     style: SweetAlertV2Style.error,
                        //     titleStyle: const TextStyle(
                        //       fontFamily: "Work Sans",
                        //       fontSize: 10,
                        //       fontWeight: FontWeight.w400,
                        //     ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Invalid email address sent',
                            ),
                          ),
                        );
                      } else {
                        // registrationData.setFirstname = firstname.text;
                        // registrationData.setEmail = email.text;
                        // registrationData.setLastname = lastname.text;
                        // registrationData.setReferral = referral.text;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SetupPassword(),
                          ),
                        );
                      }
                    },
                    child: AuthButtons(
                        hasImage:
                            (isLoading) ? "assets/images/loader.gif" : null,
                        color: (isLoading) ? signInPlaceholder : null,
                        imageWidth: (isLoading) ? 50 : null,
                        imageheight: (isLoading) ? 30 : null,
                        form: true,
                        text: (isLoading) ? "" : "Continue",
                        route: const SetupPassword()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
