import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/registration_controller.dart';
import '../../../constants/colors.dart';

class UserData extends StatelessWidget {
  // final TextEditingController firstname;
  // final TextEditingController lastname;
  // final TextEditingController email;
  // final TextEditingController phone;
  // final TextEditingController referrer;

  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registrationController = Get.find<RegistrationController>();
    return Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.5.w),
          child: SizedBox(
              width: 80.w,
              child: TextFormField(
                controller: registrationController.firstname,
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
                  prefixIcon: Stack(
                    alignment: AlignmentDirectional.center,
                    children: const [
                      Image(image: AssetImage("assets/images/shield.png")),
                      Image(image: AssetImage("assets/images/key.png")),
                    ],
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.5.w),
          child: SizedBox(
              width: 80.w,
              child: TextFormField(
                controller: registrationController.lastname,
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
                  prefixIcon:  Stack(
                    alignment: AlignmentDirectional.center,
                    children: const[
                      Image(image: AssetImage("assets/images/shield.png")),
                      Image(image: AssetImage("assets/images/key.png")),
                    ],
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.5.w),
          child: SizedBox(
              width: 80.w,
              child: TextFormField(
                controller: registrationController.email.text != ''
                    ? registrationController.phone
                    : registrationController.email,
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
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: registrationController.email.text != ''
                      ? "Phone"
                      : "Email",
                  hintStyle: const TextStyle(
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: signInPlaceholder,
                  ),
                  prefixIcon:  Stack(
                    alignment: AlignmentDirectional.center,
                    children:const [
                      Image(image: AssetImage("assets/images/shield.png")),
                      Image(image: AssetImage("assets/images/key.png")),
                    ],
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.5.w),
          child: SizedBox(
              width: 80.w,
              child: TextFormField(
                controller: registrationController.referral,
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
                  hintText: "Referal Code",
                  hintStyle: const TextStyle(
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: signInPlaceholder,
                  ),
                  prefixIcon:  Stack(
                    alignment: AlignmentDirectional.center,
                    children:const [
                      Image(image: AssetImage("assets/images/shield.png")),
                      Image(image: AssetImage("assets/images/key.png")),
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }
}
