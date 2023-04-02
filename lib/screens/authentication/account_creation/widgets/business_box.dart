import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BusinessBox extends StatelessWidget {
  final bool isBiz;
  const BusinessBox({super.key, required this.isBiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 5.w),
      child: Container(
        alignment: Alignment.topLeft,
        height: 140,
        decoration: (isBiz)
            ? DottedDecoration(
                shape: Shape.box, color: fagoSecondaryColor, dash: const [3, 3])
            : const BoxDecoration(
                color: boxDecorationBackground,
                borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: (isBiz == true)
                        ? Image.asset("assets/images/check_Icon.png")
                        : SizedBox(
                            height: 2.h,
                          ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset("assets/images/Ellipse 62.png"),
                          Image.asset("assets/images/biz_Icon.png")
                        ],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: const AutoSizeText(
                              "Business Account",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 50.w,
                            child: const AutoSizeText(
                              "Are you a professional? Creatives or live abroad?  You can collect payments",
                              // "hello",
                              textAlign: TextAlign.left,
                              minFontSize: 10,
                              stepGranularity: 10,
                              maxLines: 4,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
