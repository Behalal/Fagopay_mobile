import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/models/register_request/register.model.dart';
import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:fagopay/screens/authentication/account_creation/setup_password.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/user_details.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class IndividualDetails extends ConsumerStatefulWidget {
  const IndividualDetails({super.key});

  @override
  ConsumerState<IndividualDetails> createState() => _IndividualDetailsState();
}

class _IndividualDetailsState extends ConsumerState<IndividualDetails> {
  late bool isLoading;
  late String identifier;
  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    identifier = registrationData.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstname = TextEditingController();
    TextEditingController lastname = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController referral = TextEditingController();
    Functions function = Functions();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentStep(step: "3", backRoute: const SelectVerificationType()),
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
                firstname: firstname,
                lastname: lastname,
                email: email,
                referrer: referral,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                child: GestureDetector(
                  onTap: () {
                    if (firstname.text.isEmpty ||
                        lastname.text.isEmpty ||
                        email.text.isEmpty) {
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
                    } else if (!function.validateEmail(email.text)) {
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
                      registrationData.setFirstname = firstname.text;
                      registrationData.setEmail = email.text;
                      registrationData.setLastname = lastname.text;
                      registrationData.setReferral = referral.text;

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SetupPassword()));
                    }
                  },
                  child: AuthButtons(
                      hasImage: (isLoading) ? "assets/images/loader.gif" : null,
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
    );
  }
}
