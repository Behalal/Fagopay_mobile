import 'package:auto_size_text/auto_size_text.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
            mainAxisAlignment: (onlyText)? MainAxisAlignment.center :MainAxisAlignment.start,
            crossAxisAlignment: (onlyText)? CrossAxisAlignment.center: CrossAxisAlignment.start,
            children: [
              if (firstBoxImage != null)
                SizedBox(
                  height: 4.h,
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: Image.asset(
                      firstBoxImage!,
                      color: textImageColor,
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
                mainAxisAlignment:(onlyText)? MainAxisAlignment.center :MainAxisAlignment.start,
                crossAxisAlignment: (onlyText)? CrossAxisAlignment.center: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 1.5.w),
                  AutoSizeText(
                    firstBoxMainValue,
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 32,
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
        Container(
          width: 43.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: (boxBackground != null)
                ? boxBackground
                : fagoSecondaryColorWithOpacity10,
          ),
          child: Column(
            mainAxisAlignment: (onlyText)? MainAxisAlignment.center :MainAxisAlignment.start,
            crossAxisAlignment: (onlyText)? CrossAxisAlignment.center: CrossAxisAlignment.start,
            children: [
              if (secondBoxImage != null)
                SizedBox(
                  height: 4.h,
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: Image.asset(
                      secondBoxImage!,
                      color: textImageColor,
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
                mainAxisAlignment: (onlyText)? MainAxisAlignment.center :MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 1.5.w),
                  AutoSizeText(
                    secondBoxMainValue,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 32,
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
                secondBoxDescription,
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
        )
      ],
    );
  }
}
