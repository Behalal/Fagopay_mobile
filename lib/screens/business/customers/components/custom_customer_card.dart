import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCustomerCard extends StatelessWidget {
  const CustomCustomerCard({
    super.key,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.onPressed,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.2, color: black),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 43.w,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/customer_pic.png"),
                InkWell(
                  onTap: onPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      AutoSizeText(
                        fullName,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            color: inactiveTab,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      AutoSizeText(
                        email,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 43.w,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                        children: [
                          TextSpan(
                              text: 'CR:',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          TextSpan(
                            text: 'NGN 500',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.w, vertical: 0.5.h),
                      decoration: const BoxDecoration(
                          color: fagoGreenColorWithOpacity10,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/biz_call.png"),
                          AutoSizeText(
                            phoneNumber,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: fagoGreenColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/images/edit.png"),
              ],
            ),
          )
        ],
      ),
    );
  }
}