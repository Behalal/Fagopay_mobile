import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/dashboard/requests/requests.dart';
import 'package:fagopay/screens/dashboard/requests/support_request.dart';
import 'package:fagopay/screens/dashboard/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MakeRequest extends StatelessWidget {
  const MakeRequest({super.key});

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
                ProgressStyle(
                    stage: 50,
                    pageName: "Request Money",
                    backRoute: const RequestHome()),
                SizedBox(
                  height: 1.h,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "User must have an account with fagopay, Transactions charge will be deducted from the senders account",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: DottedDecoration(
                      linePosition: LinePosition.bottom,
                      color: transactionKeys,
                      dash: const [3, 3]),
                ),
                SizedBox(
                  height: 3.h,
                ),
                // FagoTransactionForm(page: "", cancelRoute: const RequestHome()),
                // ignore: prefer_const_constructors
                AutoSizeText(
                  "Request Form",
                  style: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 15,
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
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      hintText: "Enter User's Phone",
                      hintStyle: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //     height: 2.h,
                // ),
                Container(
                  width: 90.w,
                  decoration: const BoxDecoration(
                      color: fagoSecondaryColorWithOpacity10,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                            image: AssetImage("assets/images/account.png")),
                        SizedBox(
                          width: 2.w,
                        ),
                        const AutoSizeText(
                          "Ibrahim Lukman",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: welcomeText,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const AutoSizeText(
                  "Enter Amount",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 1.h,
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
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
                      hintText: "Amount to request",
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
                  "Narrante your Need",
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
                        fontFamily: "work Sans",
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
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      hintText: "Enter Narration",
                      hintStyle: const TextStyle(
                        fontFamily: "work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.5.h),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SupportRequest())),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 1.w,
                          ),
                          const AutoSizeText(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
