import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class AuthButtons extends StatelessWidget {
  String text;
  Widget? route;
  bool form;
  String? hasImage;
  String? suffixImage;
  double? imageheight;
  double? imageWidth;
  Color? color;

  AuthButtons({
      super.key,
      required this.text,
      this.route,
      this.hasImage,
      this.suffixImage,
      this.color,
      this.imageWidth,
      this.imageheight,
      required this.form,
  });

  @override
  Widget build(BuildContext context) {
    if ((!form)) {
      return GestureDetector(
        onTap: () {
          if (route != null) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => route!));
          }
        },
        child: Container(
          width: 70.w,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: (color == null) ? buttonColor : color,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasImage != null)
                Image.asset(
                  hasImage!,
                  width: imageWidth,
                  height: imageheight,
                  fit: BoxFit.fitWidth,
                ),
              if (hasImage != null ) SizedBox(width: 1.2.w),
              if (text.isNotEmpty)
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w600,
                      color: white),
                ),
              if (suffixImage != null ) SizedBox(width: 1.2.w),
               if (suffixImage != null)
                Image.asset(
                  suffixImage!,
                  width: imageWidth,
                  height: imageheight,
                  fit: BoxFit.fitWidth,
                ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: 70.w,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: (color == null) ? buttonColor : color,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasImage != null)
              Image.asset(
                hasImage!,
                width: imageWidth,
                height: imageheight,
                fit: BoxFit.fitWidth,
              ),
            if (hasImage != null) SizedBox(width: 1.2.w),
            if (text.isNotEmpty)
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w600,
                    color: white),
              ),
          ],
        ),
      );
    }
  }
}
