import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:get/get.dart';
import '../../../controllers/request_money_controller.dart';
import '../../../functions/functions.dart';
import '../../../models/request_money/request_money_model.dart';
import '../../authentication/recover_password_otp_screen.dart';
import 'create_payment_link.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupportRequest extends StatefulWidget {
  final MyRequest item;
  const SupportRequest({super.key, required this.item});

  @override
  State<SupportRequest> createState() => _SupportRequestState();
}

class _SupportRequestState extends State<SupportRequest> {
  bool isLoading = false;
  final _pinController = Get.find<RequestMoney>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressStyle(
                    stage: 50,
                    pageName: "Support Request",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

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
                                   text: widget.item.requestedbyname,
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
                               vertical: 1.5.h, horizontal: 3.w),
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
                                           widget.item.requestedbyname!,
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
                         height: 2.5.h,
                       ),
                       const AutoSizeText(
                         "You may enter a custom amount ?",
                         style: TextStyle(
                             color: stepsColor,
                             fontFamily: "Work Sans",
                             fontWeight: FontWeight.w400,
                             fontSize: 14),
                       ),
                       SizedBox(height: 1.h,),
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
                             hintText: "Enter an amount",
                             hintStyle: const TextStyle(
                               fontFamily: "Work Sans",
                               fontWeight: FontWeight.w400,
                               fontSize: 14,
                               color: signInPlaceholder,
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 3.h,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SvgPicture.asset('assets/icons/markIcon.svg'),
                           SizedBox(
                             width: 0.4.h,
                           ),
                           const  Flexible(
                             child:  AutoSizeText(
                               "By clicking on I support or using the custom box, I consent \nthat Fagopay shall debit my wallet to credit the requestee.",
                               style: TextStyle(
                                 fontFamily: "Work Sans",
                                 fontSize: 11,
                                 fontWeight: FontWeight.w300,
                                 color: stepsColor,
                               ),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 2.h,
                       ),
                       isLoading? const Center(child: LoadingWidget(color: fagoSecondaryColor)):Column(
                         children: [
                           GestureDetector(
                             onTap: (){
                               showPopUp(true);
                             },
                             child:   Padding(
                               padding: EdgeInsets.symmetric(
                                   horizontal: 10.w, vertical: 2.h),
                               child: AuthButtons(
                                   form: true,
                                   text: "Pay Now",
                                   //route: const CreatePaymentLink()
                               ),
                             ),
                           ),
                           SizedBox(height: 1.h,),
                           Center(
                             child: GestureDetector(
                               onTap:(){
                                 showPopUp(false);
                               },
                               child: Container(
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
                                      AutoSizeText(
                                       "Reject Request",
                                       textAlign: TextAlign.center,
                                       style: Constant().textStyle(size: 16,weight: FontWeight.w600),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                 ),
                ],
              ),
          ),
        ),
    );
  }
  cancelRequest(bool isApprove)async{
    setState(() {
      isLoading = true;
    });
    var data = {
      "amount": widget.item.requestedAmount.toString(),
      "request_id": widget.item.id.toString(),
      // "transaction_pin": _pinController.paymentPin,
      "action": "decline",
      "comment": "Unable to approve such amount due to stringent cash inflow",
    };
    var data2 = {
      "amount": widget.item.requestedAmount.toString(),
      "request_id": widget.item.id.toString(),
       "transaction_pin": _pinController.paymentPin,
      "action": "approve",
      "comment": "Unable to approve such amount due to stringent cash inflow"
    };
    RequestMoney().processRequestMoney(data: isApprove?data2:data).then((value) {
     var res =  value?.data;
     print( res['data']['error']);
     if(res['data']['code'] == 200){
       setState(() {
         isLoading = false;
       });
       Get.snackbar('Success', res['data']['message']);
       Navigator.pop(context,true);
     }else{
       Get.snackbar(
           'Error',
           res['data']['error'],
       );
       setState(() {
         isLoading = false;
       });
     }
    });
  }
  showPopUp(bool status){
    Widget approveRequest(){
      return  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Pay Request',style:  Constant().textStyle(size: 18, weight: FontWeight.w700))),
          SizedBox(height: 2.5.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.h),
            child: Text('You will be debited from your account if you confirm to pay this request.',
              textAlign: TextAlign.center,
              style:  Constant().textStyle(size: 14, weight: FontWeight.w400,color: stepsColor),
            ),
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.8.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: buttonColor),
                        color: white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    child: AutoSizeText(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style:  Constant().textStyle(size: 16,weight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    Functions().paymentDialPopUp(onTap: (){

                      Navigator.pop(context);
                      cancelRequest(true);
                    },context: context);
                 //   cancelRequest(true);
                  },
                  child: AuthButtons(
                    form: true,
                    text: "Confirm",
                    //route: const CreatePaymentLink()
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
    Widget disapproveRequest(){
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Reject Request',style:  Constant().textStyle(size: 18, weight: FontWeight.w700))),
          SizedBox(height: 2.5.h,),
          Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.h),
              child: RichText(text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Are you sure to reject this',
                        style:  Constant().textStyle(size: 18, weight: FontWeight.w700,color: stepsColor)
                    ),
                    TextSpan(
                        text: ' Request?',
                        style:  Constant().textStyle(size: 18, weight: FontWeight.w700)
                    ),
                  ]
              ),
              )
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    cancelRequest(false);
                  },
                  child: AuthButtons(
                    form: true,
                    text: "Confirm",
                    //route: const CreatePaymentLink()
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.8.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: buttonColor),
                        color: white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    child: AutoSizeText(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style:  Constant().textStyle(size: 16,weight: FontWeight.w600,),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
         padding:   EdgeInsets.symmetric(horizontal: 3.w,vertical: 6.h),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
          ),
          child:  status ? approveRequest():disapproveRequest()
        );
      },
      isScrollControlled: true,
    );

  }


}
