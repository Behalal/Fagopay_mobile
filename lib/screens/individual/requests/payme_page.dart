// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/individual/requests/share_payment_link.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/payment_link.dart';
import '../../../controllers/user_controller.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../widgets/head_style_extra_pages.dart';

class PleasePayMePage extends StatefulWidget {
  const PleasePayMePage({
    super.key,
  });

  @override
  State<PleasePayMePage> createState() => _PleasePayMePageState();
}

class _PleasePayMePageState extends State<PleasePayMePage> {
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;
  final _userUcontroller = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();

  final _paymentController = Get.find<PaymentLinkController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const  ProgressStyle(
                    stage: 0,
                    pageName: "Create Payment Link",
                    // backRoute: MakeRequest(),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 6.h,
                              ),
                              Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: fagoSecondaryColor.withOpacity(0.05),
                                        child: Text(
                                          _userUcontroller.switchedAccountType == 2 ? '${_companyController.company?.companyName?.substring(0, 1)}'??'' :
                                          '${_userUcontroller.user?.firstName?.substring(0, 1)}${_userUcontroller.user?.lastName?.substring(0, 1)}',
                                          style: textStyle(size: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,space: 2),),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      AutoSizeText(
                                          _userUcontroller.switchedAccountType == 2 ? '${_companyController.company?.companyName?.toUpperCase()}' :
                                          '${_userUcontroller.user?.firstName?.toUpperCase()} ${_userUcontroller.user?.lastName?.toUpperCase()}',
                                          style: textStyle(size: 18,fontWeight: FontWeight.w700)
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 3.h,
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
                              const AutoSizeText(
                                'Enter Amount',
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
                              NameTextfield(
                                // controller: _userController.nameController,
                                controller: _paymentController.amount,
                                keyboadType: TextInputType.number,
                                title: '0',
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Note must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/markIcon.svg'),
                                  const SizedBox(width: 8,),
                                  Flexible(
                                    child: RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'By clicking on the pay button, I agree to Fagopay  terms and conditions. ',
                                                  style: textStyle()
                                              ),
                                              TextSpan(
                                                text: 'terms',
                                                style: textStyle(color: fagoSecondaryColor),
                                              ),
                                              TextSpan(
                                                  text: ' and ',
                                                  style: textStyle()
                                              ),
                                              TextSpan(
                                                  text: 'conditions.',
                                                  style: textStyle(color: fagoSecondaryColor)
                                              ),
                                            ]
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: ()async{
                                    if(_paymentController.amount.text.isEmpty){
                                      Get.snackbar(
                                          'Error',
                                          'Amount is required', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                    }else if(int.parse(_paymentController.amount.text) <1000){
                                      Get.snackbar(
                                          'Error',
                                          'Minimum amount is 1000 naira', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                    }
                                    else{
                                      _paymentController.generatePaymentPin(context);
                                    }
                                  },
                                  child: AuthButtons(
                                    form: true,
                                    text: "Create Payment Link",
                                    route: const SharePaymentLink(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ])));
  }

  createLink(){

  }

  TextStyle textStyle({ double? size, FontWeight? fontWeight,Color ?color,double? space}){
    return  TextStyle(
      fontFamily: "Work Sans",
      fontSize: size??14,
      letterSpacing: space??0,
      fontWeight: fontWeight??FontWeight.w500,
      color: color??stepsColor,
    );
  }
}
