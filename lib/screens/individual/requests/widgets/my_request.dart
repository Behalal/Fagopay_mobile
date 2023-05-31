import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/request_money_controller.dart';
import '../../../authentication/recover_password_otp_screen.dart';
import '../../../constants/colors.dart';
import '../../../constants/currency.dart';
class MyRequestWidget extends StatelessWidget {
  MyRequestWidget({Key? key}) : super(key: key);
  final _moneyRequest = Get.put(RequestMoney());
  int? myRequestType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      width: Get.width,
      child: Obx(() {
        return _moneyRequest.myRequestStatus == MyRequestStatus.loading
            ? const LoadingWidget(color: fagoSecondaryColor,)
            : _moneyRequest.myRequestList.isNotEmpty
            ? ListView.separated(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: false,
            itemCount: _moneyRequest.myRequestList.length,
            separatorBuilder:
                (context, index) => SizedBox(height: 1.6.h,),
            itemBuilder: (context, index) {
              var item = _moneyRequest.myRequestList[index];
              return InkWell(
                onTap: () {
                  myRequestType = index;

                  // setState(() {
                  // });
                },
                child: Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(4,
                            4), // Shadow position
                      ),
                    ],
                    // border: const Border(
                    //     bottom: BorderSide(
                    //         width: 1,
                    //         color: fagoBlackColorWithOpacity)),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.8.h),
                    child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        children: [
                          SizedBox(
                            width: 55.w,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  children: [
                                    const AutoSizeText(
                                      "Requested",
                                      style:
                                      TextStyle(
                                        fontFamily:
                                        "Work Sans",
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.w700,
                                        color:
                                        stepsColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      1.w,
                                    ),
                                    AutoSizeText(
                                      "$currencySymbol ${item.requestedAmount}",
                                      style:
                                      const TextStyle(
                                        fontFamily:
                                        "Work Sans",
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.w700,
                                        color:
                                        fagoSecondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      1.w,
                                    ),
                                    const AutoSizeText(
                                      "from",
                                      style:
                                      TextStyle(
                                        fontFamily:
                                        "Work Sans",
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.w700,
                                        color:
                                        stepsColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                AutoSizeText(
                                  item.requestedfromname
                                      .toString(),
                                  style:
                                  const TextStyle(
                                    fontFamily:
                                    "Work Sans",
                                    fontSize:
                                    14,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    color:
                                    stepsColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                AutoSizeText(
                                  "${item.createdAt!.year.toString()}-${item.createdAt!.month.toString().padLeft(2, '0')}-${item.createdAt!.day.toString().padLeft(2, '0')} ${item.createdAt!.hour.toString().padLeft(2, '0')}:${item.createdAt!.minute.toString().padLeft(2, '0')}",
                                  style:
                                  const TextStyle(
                                    fontFamily:
                                    "Work Sans",
                                    fontSize:
                                    12,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    color:
                                    stepsColorWithOpacity55,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: "",
                                  middleText:
                                  "",
                                  titlePadding:
                                  EdgeInsets
                                      .zero,
                                  contentPadding: const EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      8,
                                      vertical:
                                      8),
                                  content:
                                  dialogItem());
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
  Widget dialogItem() {
    return SizedBox(
      height: 200,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AutoSizeText(
            "Reject Request",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AutoSizeText(
                "Are you sure to reject this",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: stepsColor,
                ),
              ),
              AutoSizeText(
                " Request",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
          const AutoSizeText(
            '"Helping someone else doesn’t decrease \nyour wealth”',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: stepsColorWithOpacity55,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            "Thomas Fries",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: stepsColor,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 1.w,
                      ),
                      const AutoSizeText(
                        "Confirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 130,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: buttonColor),
                    color: white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 1.w,
                      ),
                      const AutoSizeText(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w600,
                          color: buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
