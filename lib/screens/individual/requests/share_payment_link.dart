// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/requests/payme_page.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/user_controller.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SharePaymentLink extends StatefulWidget {
  const SharePaymentLink({
    super.key,
  });

  @override
  State<SharePaymentLink> createState() => _SharePaymentLinkState();
}

class _SharePaymentLinkState extends State<SharePaymentLink> {
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;
  String paymentUrl = '';

  @override
  void initState() {
    checkLink();
    super.initState();
  }
  final _userUcontroller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Payment Link",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            const AutoSizeText(
                              "Get paid from anyone",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: fagoSecondaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            const AutoSizeText(
                              "Copy and share your payment link with anyone and start receiving money.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: inactiveTab,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              height: 25.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset:
                                        const Offset(2, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: fagoSecondaryColor.withOpacity(0.05),
                                    child: Text(
                                        '${_userUcontroller.user?.firstName?.substring(0, 1)}${_userUcontroller.user?.lastName?.substring(0, 1)}',
                                      style: textStyle(size: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,space: 2),),
                                  ),
                                   AutoSizeText(
                                    "${_userUcontroller.user?.firstName} ${_userUcontroller.user?.lastName}",
                                    style: textStyle(size: 22,fontWeight:  FontWeight.w700)
                                  ),
                                  paymentUrl.isEmpty?Text('No payment link yet',style: textStyle(size: 15,fontWeight:  FontWeight.w500,),):Container(),
                                  paymentUrl.isEmpty? GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PleasePayMePage())).then((value){
                                        setState(() {
                                          paymentUrl = value ?? paymentUrl;
                                        });
                                      });
                                    },
                                    child: AuthButtons(
                                        form: true,
                                        text: "Create Link",
                                        route: const PleasePayMePage()),
                                  ):
                                  GestureDetector(
                                    onTap: (){
                                      FlutterClipboard.copy(paymentUrl).then((value){
                                        Get.snackbar('Payment link Copied',
                                            paymentUrl,
                                            snackPosition: SnackPosition.BOTTOM,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 3.h,
                                              vertical: 2.h,
                                            ));
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      height: 6.h,
                                      //width: 35.5.h,
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(36),
                                          border: Border.all(
                                              color: fagoSecondaryColor)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                           Flexible(
                                             child: Text(
                                               maxLines: 1,
                                              paymentUrl,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: fagoSecondaryColor,
                                              ),
                                          ),
                                           ),
                                          // const Spacer(),
                                          SvgPicture.asset('assets/icons/copy-svgrepo-com 1.svg')
                                        ],
                                      ),
                                    ),
                                  ),
                                  paymentUrl.isEmpty?Container():GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PleasePayMePage())).then((value){
                                      setState(() {
                                        paymentUrl = value?? paymentUrl;
                                      });
                                      });
                                    },
                                    child: RichText(
                                        text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Click',
                                          style: textStyle(size: 14, fontWeight: FontWeight.w600)
                                        ),
                                        TextSpan(
                                            text: ' here ',
                                            style: textStyle(size: 14, fontWeight: FontWeight.w700,color: fagoSecondaryColor)
                                        ),
                                        TextSpan(
                                            text: 'to edit link',
                                            style: textStyle(size: 14, fontWeight: FontWeight.w600)
                                        ),
                                      ]
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            ///Code for sharing link
                            paymentUrl.isEmpty?Container():GestureDetector(
                              onTap: (){
                                Share.share('${_userUcontroller.user?.firstName} request you make a payment using this link $paymentUrl');
                              },
                              child: AuthButtons(
                                  form: true,
                                  text: "Share Payment Link",
                                  route: const PleasePayMePage()),
                            ),
                          ],
                        )),
                  ),
                ])));
  }
  checkLink()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      paymentUrl = localStorage.getString("paymentLink")!;
    });
  }
  TextStyle textStyle({required double size,required FontWeight fontWeight,Color ?color,double? space}){
    return  TextStyle(
      fontFamily: "Work Sans",
      fontSize: size,
      letterSpacing: space??0,
      fontWeight: fontWeight,
      color: color??stepsColor,
    );
  }
}
