import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../individual/widgets/business_warning.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import 'all_admin.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProgressStyle(
                        stage: 50,
                        width: 4,
                        pageName: "Add Admin",
                        backRoute: AllAdmin(),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const BusinessWarning(),
                      SizedBox(
                        height: 2.h,
                      ),
                      const AutoSizeText(
                        "Find Employee by Phone",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            color: welcomeText,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      const AutoSizeText(
                        "Employee must be a registered fago user with KYC completed",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        child: TextFormField(
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            hintText: "Enter Employee Phone ",
                            hintStyle: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 90.w,
                        decoration: const BoxDecoration(
                            color: fagoSecondaryColorWithOpacity10,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                  image:
                                      AssetImage("assets/images/account.png")),
                              SizedBox(
                                width: 2.w,
                              ),
                              const AutoSizeText(
                                "Ibrahim Lukman",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: inactiveTab,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const BusinessWarning(
                        boxBackground: fagoGreenColorWithOpacity10,
                        warningImage: "assets/images/green_warning.png",
                        warning:
                            "By clicking on submit, I consent to add this user to my business page and may have access to whichever ofmy business account I add them to.",
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: AuthButtons(
                            form: true, text: "Add Admin", route: null),
                      )
                    ]))));
  }
}
