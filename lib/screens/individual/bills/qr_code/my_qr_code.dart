import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/bills/qr_code/create_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/head_style_extra_pages.dart';
class MyQrCode extends StatefulWidget {
  const MyQrCode({Key? key}) : super(key: key);

  @override
  State<MyQrCode> createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "My Qr Code",
              // backRoute: MakeRequest(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h,),
                  Text('Scan The QR Code',style: Constant().textStyle(size: 19, weight: FontWeight.w700),),
                  SizedBox(height: 0.8.h,),
                  Text('Your customers can use any bank app to scan the QR code below to pay you',style: Constant().textStyle(size: 15, weight: FontWeight.w400,color: stepsColor),),
                  SizedBox(height: 3.h,),
                  Center(child: CircleAvatar(radius: 30,)),
                  SizedBox(height: 0.8.h,),

                  Center(child: Text('Halar Venture Limited',style: Constant().textStyle(size: 17, weight: FontWeight.w500,color: fagoBlackColor),)),
                  SizedBox(height: 0.8.h,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('9898788766',style: Constant().textStyle(size: 17, weight: FontWeight.w500,color: fagoBlackColor),)),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Center(child: Text('Providus Bank',style: Constant().textStyle(size: 17, weight: FontWeight.w500,color: fagoBlackColor),)),

                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: double.infinity ,
                    height: 250,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 3.h,),
                  Center(
                    child: Constant().btn(text: 'Download QR Code', img: 'assets/images/document-download.png', color: fagoSecondaryColor, onTap: (){}),
                  ),
                  SizedBox(height: 1.h,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateQrCode()));
                      },
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Generate',
                                    style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: stepsColor)
                                ),
                                TextSpan(
                                    text: ' One-time ',
                                    style: Constant().textStyle(size: 14, color: fagoSecondaryColor, weight: FontWeight.w700)
                                ),
                                TextSpan(
                                    text: 'Code',
                                    style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: stepsColor)
                                ),
                              ]
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/nibss.png',height: 35),
                      SizedBox(width: 3.w,),
                      Image.asset('assets/images/nqr.png',height: 35),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Center(
                    child: Text(
                     'Secured by NIBSS',
                     style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: stepsColor)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
