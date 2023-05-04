import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({super.key});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 1.h,
                left: 4.w,
                right: 4.w,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: const ProgressStyle(
                stage: 0,
                pageName: "View Invoice",
                shadow: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 45.w,
                        child: const AutoSizeText(
                          "Obasana Designs",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const AutoSizeText(
                              "+23490173458",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            const AutoSizeText(
                              "obasana@gmail.com",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 45.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                AutoSizeText(
                                  "Invoice No.",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "#INV124560",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                AutoSizeText(
                                  "Issued Date:",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "23 Apr, 2023",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                AutoSizeText(
                                  "Due Date:",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "04 May, 2023",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const AutoSizeText(
                              "C14, bodija, ibadan,",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            const AutoSizeText(
                              "Oyo, Nigeria",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
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
                        width: 45.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Invoice to:",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            const AutoSizeText(
                              "Halal Payment Limited",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            const AutoSizeText(
                              "+2349017345 | obasana@gmail.com",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const AutoSizeText(
                              "C14, bodija, ibadan,",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            const AutoSizeText(
                              "Oyo, Nigeria",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    decoration: const BoxDecoration(
                        color: fagoSecondaryColorWithOpacity10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: const AutoSizeText(
                            "Description",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const AutoSizeText(
                          "Unit*Rate",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: fagoSecondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const AutoSizeText(
                          "Total (NGN)",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: fagoSecondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: const AutoSizeText(
                              "Food items for Eid Kabir",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const AutoSizeText(
                            "1 * 200,000",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const AutoSizeText(
                            "200,000",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Image.asset(
                            "assets/images/archive.png",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: const AutoSizeText(
                              "Food items for Eid Kabir",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const AutoSizeText(
                            "1 * 200,000",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const AutoSizeText(
                            "200,000",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Image.asset(
                            "assets/images/archive.png",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      AutoSizeText(
                        "Total",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          color: inactiveTab,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AutoSizeText(
                        "200,000",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      AutoSizeText(
                        "Tax (7.5% VAT)",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      AutoSizeText(
                        "200,000",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      AutoSizeText(
                        "Discount (12%)",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      AutoSizeText(
                        "200,000",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Grand Total",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          color: fagoSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AutoSizeText(
                        "${currencySymbol}200,000",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: fagoSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: inactiveTab,
                      ),
                      children: [
                        TextSpan(
                          text: 'Note: ',
                          style: TextStyle(
                            color: fagoSecondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Payment should be made to',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Account Name:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: const AutoSizeText(
                          "Halal Payment Limited.",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: inactiveTab,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Account no:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20.w,
                              child: const AutoSizeText(
                                "2038274657",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  color: inactiveTab,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              "assets/images/copy-svgrepo-com.png",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Bank:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: const AutoSizeText(
                          "Guaranty Trust Bank",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: inactiveTab,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 1,
              decoration: const BoxDecoration(
                color: fagoBlackColorWithOpacity10,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.5.h,
                horizontal: 6.w,
              ),
              decoration: const BoxDecoration(
                color: fagoSecondaryColorWithOpacity10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: AuthButtons(
                      text: "Mail Invoice",
                      form: false,
                      suffixImage: "assets/images/sms-tracking.png",
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: AuthButtons(
                      text: "Download",
                      form: false,
                      color: fagoPrimaryColor,
                      suffixImage: "assets/images/document-download.png",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
