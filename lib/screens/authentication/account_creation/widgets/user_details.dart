import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserData extends StatelessWidget {
  TextEditingController firstname;
  TextEditingController lastname;
  TextEditingController email;
  TextEditingController referrer;
  UserData(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.referrer});

  @override
  Widget build(BuildContext context) {
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
                controller: firstname,
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
                controller: lastname,
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
                controller: email,
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
                  hintText: "Email",
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
                controller: referrer,
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
                  prefixIcon: Stack(
                    alignment: AlignmentDirectional.center,
                    children: const [
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
