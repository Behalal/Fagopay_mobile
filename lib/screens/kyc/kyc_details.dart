import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../authentication/account_creation/widgets/current_step.dart';
import '../authentication/widgets/auth_buttons.dart';
import '../constants/colors.dart';
import 'kyc1.dart';
import 'kyc2.dart';

class KycDetailsScreen extends StatefulWidget {
  const KycDetailsScreen({super.key});

  @override
  State<KycDetailsScreen> createState() => KycDetailsScreenState();
}

class KycDetailsScreenState extends State<KycDetailsScreen> {
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
                CurrentStep(step: "3", backRoute: const BvnVerification()),
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
                // const UserData(),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: "Firstname",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                          prefixIcon: const Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image(image: AssetImage("assets/images/call.png")),
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: "Lastname",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                          prefixIcon: const Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image(
                                  image:
                                      AssetImage("assets/images/lastname.png")),
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: "DOB",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                          prefixIcon: const Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image(image: AssetImage("assets/images/dob.png")),
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: AuthButtons(
                      form: false,
                      text: "Continue",
                      route: const KycVerfication(accountType: 'individual',)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
