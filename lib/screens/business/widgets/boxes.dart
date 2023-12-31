import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class CustomerBox extends StatelessWidget {
  String? firstBoxImage;
  String firstBoxMainValue;
  String firstBoxDescription;
  String? secondBoxImage;
  String secondBoxMainValue;
  String secondBoxDescription;
  Color? boxBackground;
  Color? textImageColor;
  bool onlyText;
  void Function()? onTap;

  CustomerBox({
    Key? key,
    required this.firstBoxDescription,
    required this.firstBoxMainValue,
    required this.secondBoxDescription,
    required this.secondBoxMainValue,
    this.firstBoxImage,
    this.secondBoxImage,
    this.boxBackground,
    this.textImageColor,
    this.onlyText = false,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 43.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: (boxBackground != null)
                ? boxBackground
                : fagoSecondaryColorWithOpacity10,
          ),
          child: Column(
            mainAxisAlignment:
                (onlyText) ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: (onlyText)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              if (firstBoxImage != null)
                SizedBox(
                  height: 4.h,
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: SvgPicture.asset(
                      firstBoxImage!,
                      color: textImageColor,
                      height: 3.h,
                      width: 3.w,
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 1.5.h,
                ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: (onlyText)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: (onlyText)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 1.5.w),
                  AutoSizeText(
                    firstBoxMainValue,
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 28,
                        color: (textImageColor != null)
                            ? textImageColor
                            : fagoSecondaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              AutoSizeText(
                firstBoxDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    color:
                        (textImageColor != null) ? textImageColor : inactiveTab,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 43.w,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.2.h),
            decoration: const BoxDecoration(
              color:fagoSecondaryColorWithOpacity10,
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 4.h,
                  child: const CircleAvatar(
                    backgroundColor: white,
                    child: Icon(Icons.add, color: fagoSecondaryColor,),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                FittedBox(
                  child: AutoSizeText(
                    secondBoxDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 12,
                        color: (textImageColor != null)
                            ? textImageColor
                            : inactiveTab,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
