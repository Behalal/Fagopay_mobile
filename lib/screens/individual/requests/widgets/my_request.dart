import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/request_money_controller.dart';
import '../../../authentication/recover_password_otp_screen.dart';
import '../../../authentication/widgets/auth_buttons.dart';
import '../../../constants/colors.dart';
import '../../../constants/currency.dart';

class MyRequestWidget extends StatefulWidget {
  MyRequestWidget({Key? key}) : super(key: key);

  @override
  State<MyRequestWidget> createState() => _MyRequestWidgetState();
}

class _MyRequestWidgetState extends State<MyRequestWidget> {
  final _moneyRequest = Get.put(RequestMoney());


  // int? myRequestType;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      width: Get.width,
      child: Obx(() {
        return _moneyRequest.myRequestStatus == MyRequestStatus.loading || isLoading? const LoadingWidget(color: fagoSecondaryColor,)
            : _moneyRequest.myRequestList.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: _moneyRequest.myRequestList.length,
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1.6.h,
                        ),
                    itemBuilder: (context, index) {
                      var item = _moneyRequest.myRequestList[index];
                      return InkWell(
                        onTap: () {
                          _moneyRequest.cancelRequestMoney('');
                       //   print('eye');
                        },
                        child: Container(
                          height: 14.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 2,
                                offset: const Offset(4, 4), // Shadow position
                              ),
                            ],
                            // border: const Border(
                            //     bottom: BorderSide(
                            //         width: 1,
                            //         color: fagoBlackColorWithOpacity)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 55.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const AutoSizeText(
                                              "Requested",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: stepsColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            AutoSizeText(
                                              "$currencySymbol ${item.requestedAmount}",
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            const AutoSizeText(
                                              "from",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: stepsColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        AutoSizeText(
                                          item.requestedfromname.toString(),
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: stepsColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        AutoSizeText(
                                          "${item.createdAt!.year.toString()}-${item.createdAt!.month.toString().padLeft(2, '0')}-${item.createdAt!.day.toString().padLeft(2, '0')} ${item.createdAt!.hour.toString().padLeft(2, '0')}:${item.createdAt!.minute.toString().padLeft(2, '0')}",
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: stepsColorWithOpacity55,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showPopUp(item.id!);
                                      ///Old pop up show data 'delete if you want'
                                      // Get.defaultDialog(
                                      //     title: "",
                                      //     middleText: "",
                                      //     titlePadding: EdgeInsets.zero,
                                      //     contentPadding:
                                      //         const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      //     content: showPopUp(item.id!));
                                    },
                                    child: SvgPicture.asset(
                                        'assets/icons/delete_request.svg'),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: AutoSizeText(
                      'No Request found',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: stepsColor,
                      ),
                    ),
                  );
      }),
    );
  }




  showPopUp(String id) {
    Widget disapproveRequest() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('Reject Request',
                  style: textStyle(size: 18, weight: FontWeight.w700))),
          SizedBox(
            height: 2.5.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Are you sure to reject this',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w700,
                          color: stepsColor)),
                  TextSpan(
                      text: ' Request?',
                      style: textStyle(size: 18, weight: FontWeight.w700)),
                ]),
              )),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.pop(context);
                    RequestMoney().cancelRequestMoney(id).then((value) {
                      print('done aaa');
                      setState(() {
                        isLoading = false;
                      });
                      _moneyRequest.getMyRequest();
                    });
                  },
                  child: AuthButtons(
                    form: true,
                    text: "Confirm",
                    //route: const CreatePaymentLink()
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
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
                      style: textStyle(
                        size: 16,
                        weight: FontWeight.w600,
                      ),
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
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 6.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            child: disapproveRequest());
      },
      isScrollControlled: true,
    );
  }

  textStyle({required double size, required FontWeight weight, Color? color}) {
    return TextStyle(
      fontSize: size,
      fontFamily: "Work Sans",
      fontWeight: weight,
      color: color ?? buttonColor,
    );
  }
}
///Old pop up
//  Widget dialogItem() {
//     return SizedBox(
//       height: 200,
//       width: Get.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const AutoSizeText(
//             "Reject Request",
//             style: TextStyle(
//               fontFamily: "Work Sans",
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: fagoSecondaryColor,
//             ),
//           ),
//           SizedBox(
//             height: 1.5.h,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               AutoSizeText(
//                 "Are you sure to reject this",
//                 style: TextStyle(
//                   fontFamily: "Work Sans",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: stepsColor,
//                 ),
//               ),
//               AutoSizeText(
//                 " Request",
//                 style: TextStyle(
//                   fontFamily: "Work Sans",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: fagoSecondaryColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 1.5.h,
//           ),
//           const AutoSizeText(
//             '"Helping someone else doesn’t decrease \nyour wealth”',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: "Work Sans",
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: stepsColorWithOpacity55,
//             ),
//           ),
//           SizedBox(
//             height: 1.h,
//           ),
//           const AutoSizeText(
//             "Thomas Fries",
//             style: TextStyle(
//               fontFamily: "Work Sans",
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               color: stepsColor,
//             ),
//           ),
//           SizedBox(
//             height: 2.h,
//           ),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 130,
//                   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//                   alignment: Alignment.center,
//                   decoration: const BoxDecoration(
//                       color: buttonColor,
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 1.w,
//                       ),
//                       const AutoSizeText(
//                         "Confirm",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: "Work Sans",
//                           fontWeight: FontWeight.w600,
//                           color: white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 Container(
//                   width: 130,
//                   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: buttonColor),
//                     color: white,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(25),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 1.w,
//                       ),
//                       const AutoSizeText(
//                         "Cancel",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: "Work Sans",
//                           fontWeight: FontWeight.w600,
//                           color: buttonColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }