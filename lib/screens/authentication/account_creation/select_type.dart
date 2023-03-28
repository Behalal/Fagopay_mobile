import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/business_box.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/personal_box.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/terms_and_cond.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/register_request/register.model.dart';

class SelectType extends StatefulWidget {
  const SelectType({super.key});

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  late bool personalSelected;
  late bool businesSelected;

  @override
  void initState() {
    personalSelected = true;
    businesSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool isBiz = false;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CurrentStep(
              step: "1",
              backRoute: const SignIn(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Select Account Type",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 22,
                    color: fagoSecondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "What type of Account are you creating?",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    color: stepsColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            GestureDetector(
                onTap: (() {
                  setState(() {
                    personalSelected = true;
                    businesSelected = false;
                  });
                }),
                child: PersonalBox(
                  isBiz: personalSelected,
                )),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
                onTap: (() {
                  setState(() {
                    personalSelected = false;
                    businesSelected = true;
                  });
                }),
                child: BusinessBox(isBiz: businesSelected)),
                
            SizedBox(
              height: 5.h,
            ),
            const TermsAndCond(),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: () {
                  if (personalSelected) {
                    registrationData.setAccountType = "2";
                  } else {
                    registrationData.setAccountType = "1";
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SelectVerificationType(),
                    ),
                  );
                },
                child: AuthButtons(
                  form: true,
                  text: 'Continue',
                  route: const SelectVerificationType(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
