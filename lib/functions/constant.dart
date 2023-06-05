import 'package:flutter/material.dart';

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
  SizedBox longBtn({required String text,VoidCallback? tap,Color?color,TextStyle? textStyle}){
    return    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color??fagoPrimaryColor)
        ),
        onPressed: tap??(){},
        child: Text(text,
          style: textStyle??Constant().textStyle(color: Colors.white,weight: FontWeight.w500,size: 22),),
      ),
    );
  }
}