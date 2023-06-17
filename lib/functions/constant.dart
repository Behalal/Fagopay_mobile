import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../screens/constants/colors.dart';

class Constant{
  textStyle({required double size,required FontWeight weight, Color?color}){
    return TextStyle(
      fontSize: size,
      fontFamily: "Work Sans",
      fontWeight:weight,
      color: color??buttonColor,
    );
  }
  SizedBox longBtn({required String text,VoidCallback? tap,Color?color,TextStyle? textStyle,double? radius}){
    return    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation:  MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??0))),
            backgroundColor: MaterialStateProperty.all(color??fagoPrimaryColor)
        ),
        onPressed: tap??(){},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Text(text,
            style: textStyle??Constant().textStyle(color: Colors.white,weight: FontWeight.w600,size: 18),),
        ),
      ),
    );
  }
  Widget btn({required String text, required String img,required Color color,required VoidCallback onTap}){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
        decoration:   BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        width: 30.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle(size: 16,weight: FontWeight.w600,color: white),
            ),
            SizedBox(width: 1.5.w,),
            Image.asset(img,height: 20,)
          ],
        ),
      ),
    );
  }
  final formatCurrency =  NumberFormat.currency(locale: 'en_US', symbol: String.fromCharCode(0x20A6));
  chip({required String text,required Color borderColor,required Color textColor,bool color = false}){
    return Container(
      alignment: Alignment.center,
      padding:  EdgeInsets.symmetric(vertical: 1.2.h,horizontal: 3.h),
      margin: EdgeInsets.only(right: 0.5.h),
      decoration: BoxDecoration(
        color: color? fagoGreenColorWithOpacity17:white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: borderColor
          )
      ),
      child: Text(text,style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: textColor),),
    );
  }
}