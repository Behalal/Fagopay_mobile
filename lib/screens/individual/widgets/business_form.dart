import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class BusinessForm extends StatelessWidget {
  const BusinessForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          "Fullname",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: linearGradient1,
                    width: 1.0,
                    style: BorderStyle.solid
              )),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "Enter fullname",
              hintStyle: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        const AutoSizeText(
          "Phone Number",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: linearGradient1,
                    width: 1.0,
                    style: BorderStyle.solid
              )),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "Enter fullname",
              hintStyle: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        const AutoSizeText(
          "Email",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: linearGradient1,
                    width: 1.0,
                    style: BorderStyle.solid
              )),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "Enter email",
              hintStyle: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 42.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                      "Country",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid
                        )),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter country",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 42.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                      "State",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid
                        )),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter your state",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        const AutoSizeText(
          "Address, city",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: welcomeText,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 90.w,
          child: TextFormField(
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: linearGradient1,
                    width: 1.0,
                    style: BorderStyle.solid
              )),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "12, adjascent KFC, Ikoyi estate, island",
              hintStyle: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: signInPlaceholder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}