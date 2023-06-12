import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/request_money_controller.dart';
import '../../../authentication/recover_password_otp_screen.dart';
import '../../../constants/currency.dart';
import '../support_request.dart';

class RequestListWidget extends StatelessWidget {
  RequestListWidget({Key? key}) : super(key: key);
  final _moneyRequest = Get.put(RequestMoney());
  // int? myRequestType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      width: Get.width,
      child: Obx(() {
        return _moneyRequest.requestedMoneyStatus == MyRequestedMoneyStatus.loading ? const LoadingWidget(color: fagoSecondaryColor,)
            : _moneyRequest.requestedMoneyList.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: _moneyRequest.requestedMoneyList.length,
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1.6.h,
                        ),
                    itemBuilder: (context, index) {
                      var item = _moneyRequest.requestedMoneyList[index];
                      return InkWell(
                        onTap: () {
                          // setState(() {
                          // });
                          //  myRequestType = index;
                        },
                        child: Container(
                          // width: 90.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fagoSecondaryColorWithOpacity10,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        radius: 30, // Image radius
                                        backgroundImage: AssetImage(
                                            'assets/images/fago(2).png'),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            item.requestedbyname!,
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: stepsColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          AutoSizeText(
                                            "$currencySymbol ${item.requestedAmount}",
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: fagoSecondaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          AutoSizeText(
                                            " ${item.createdAt!.year.toString()}-${item.createdAt!.month.toString().padLeft(2, '0')}-${item.createdAt!.day.toString().padLeft(2, '0')} ${item.createdAt!.hour.toString().padLeft(2, '0')}:${item.createdAt!.minute.toString().padLeft(2, '0')}",
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: stepsColor,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 1.h,
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                    //  Navigator.p
                                      Get.to(() => SupportRequest(item: item,))?.then((value) {
                                        print(value);
                                        if(value != null){
                                          _moneyRequest.requestedMoney();
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 17.w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: buttonColor),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 0.5.h),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:  [
                                            AutoSizeText(
                                              "View",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
}
