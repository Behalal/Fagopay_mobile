import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/request_money/request_money_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../bills/electricity.dart';
import '../widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupportRequest extends StatefulWidget {
  final MyRequest item;
  const SupportRequest({super.key, required this.item});

  @override
  State<SupportRequest> createState() => _SupportRequestState();
}

class _SupportRequestState extends State<SupportRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ProgressStyle(
                        stage: 50,
                        pageName: "Support Request",
                        // backRoute: MakeRequest(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: stepsColor),
                            children: [
                              const TextSpan(text: 'Support '),
                              TextSpan(
                                  text: widget.item.requestedfromname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              const TextSpan(text: ' request of '),
                              TextSpan(
                                  text:
                                      '$currencySymbol ${widget.item.requestedAmount}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ]),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        height: 15.h,
                        decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 2.5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // width: 60.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          widget.item.requestedfromname!,
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: stepsColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const AutoSizeText(
                                      "Narration",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    AutoSizeText(
                                      widget.item.description!,
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "$currencySymbol  ${widget.item.requestedAmount}",
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/markIcon.svg'),
                          SizedBox(
                            width: 1.h,
                          ),
                          const AutoSizeText(
                            "By clicking on I support or using the custom box, I consent \nthat Fagopay shall debit my wallet to credit the requestee.",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: stepsColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: AuthButtons(
                            form: false,
                            text: "I Support",
                            route: const Electricity()),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: const AutoSizeText(
                          "OR",
                          style: TextStyle(
                              color: fagoSecondaryColor,
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const AutoSizeText(
                        "How much can you afford?",
                        style: TextStyle(
                            color: stepsColor,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
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
                            hintText: "Amount to request",
                            hintStyle: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder,
                            ),
                            suffixIcon: const Icon(Icons.send_outlined,
                                color: fagoSecondaryColor, size: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 70.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.8.h, horizontal: 3.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: buttonColor),
                            color: white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 1.w,
                            ),
                            const AutoSizeText(
                              "I don’t approve",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w600,
                                  color: buttonColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: stepsColor),
                            children: [
                              TextSpan(
                                  text:
                                      '“Helping someone else doesn’t decrease your\nwealth”.'),
                              TextSpan(
                                  text: 'Thomas Fries',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ]),
                      ),
                    ]))));
  }
}
