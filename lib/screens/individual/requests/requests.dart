import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/request_money_controller.dart';
import 'package:fagopay/models/my_request_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/individual/requests/support_request.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../models/request_money/request_money_model.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'make_request.dart';
import '../widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:number_display/number_display.dart';

class RequestHome extends StatefulWidget {
  //final List<MyRequest> item;

  const RequestHome({
    super.key,
  });

  @override
  State<RequestHome> createState() => _RequestHomeState();
}

class _RequestHomeState extends State<RequestHome> {
  final _moneyRequest = Get.put(RequestMoney());
  late bool MyRequest;
  late bool Request;
  int? myRequestType;
  final display = createDisplay(
    roundingType: RoundingType.floor,
    length: 15,
    decimal: 5,
  );

  @override
  void initState() {
    MyRequest = true;
    Request = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _moneyRequest.getMyRequest();
    _moneyRequest.requestedMoney();

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProgressStyle(
                        stage: 0,
                        pageName: "Request Money",
                        // backRoute: DashboardHome(
                        //   userDetails: User(),
                        // ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         const MakeRequest(),
                              //   ),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MakeRequest(),
                                ),
                              );
                            }),
                            child: Container(
                              height: 5.h,
                              width: 35.w,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: fagoSecondaryColor),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 1.5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/request_money_icon.svg'),
                                    // Icon(
                                    //   Icons.mode_standby_sharp,
                                    //   size: 15,
                                    //   color: white,
                                    // ),
                                    const AutoSizeText(
                                      "Request Now",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                MyRequest = true;
                                Request = false;
                              });
                            },
                            child: Container(
                              width: 40.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.5,
                                          color: (MyRequest)
                                              ? fagoSecondaryColor
                                              : fagoSecondaryColorWithOpacity))),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: const AutoSizeText(
                                  "My Request",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 10.w,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.5,
                                        color: fagoSecondaryColorWithOpacity))),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h)),
                          ),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                MyRequest = false;
                                Request = true;
                              });
                            }),
                            child: Container(
                              width: 40.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.5,
                                          color: (Request)
                                              ? fagoSecondaryColor
                                              : fagoSecondaryColorWithOpacity))),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: const AutoSizeText(
                                  "List of Request",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: inactiveTab,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      (MyRequest)
                          ? SizedBox(
                              height: 75.h,
                              width: Get.width,
                              child: Obx(() {
                                return _moneyRequest.myRequestStatus ==
                                        MyRequestStatus.loading
                                    ? const LoadingWidget(
                                        color: fagoSecondaryColor,
                                      )
                                    : _moneyRequest.myRequestList.isNotEmpty
                                        ? ListView.separated(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: false,
                                            itemCount: _moneyRequest
                                                .myRequestList.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      height: 1.6.h,
                                                    ),
                                            itemBuilder: (context, index) {
                                              var item = _moneyRequest
                                                  .myRequestList[index];
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    myRequestType = index;
                                                  });
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
                            )
                          : SizedBox(
                              height: 65.h,
                              width: Get.width,
                              child: Obx(() {
                                return _moneyRequest.requestedMoneyStatus ==
                                        MyRequestStatus.loading
                                    ? const LoadingWidget(
                                        color: fagoSecondaryColor,
                                      )
                                    : _moneyRequest
                                            .requestedMoneyList.isNotEmpty
                                        ? ListView.separated(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: false,
                                            itemCount: _moneyRequest
                                                .requestedMoneyList.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      height: 1.6.h,
                                                    ),
                                            itemBuilder: (context, index) {
                                              var item = _moneyRequest
                                                  .requestedMoneyList[index];
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    myRequestType = index;
                                                  });
                                                },
                                                child: Container(
                                                  // width: 90.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        fagoSecondaryColorWithOpacity10,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.w,
                                                            vertical: 1.h),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const CircleAvatar(
                                                                radius:
                                                                    30, // Image radius
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/images/fago(2).png'),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AutoSizeText(
                                                                    item.requestedbyname!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Work Sans",
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          stepsColor,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1.h,
                                                                  ),
                                                                  AutoSizeText(
                                                                    "$currencySymbol ${item.requestedAmount}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Work Sans",
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          fagoSecondaryColor,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1.h,
                                                                  ),
                                                                  AutoSizeText(
                                                                    " ${item.createdAt!.year.toString()}-${item.createdAt!.month.toString().padLeft(2, '0')}-${item.createdAt!.day.toString().padLeft(2, '0')} ${item.createdAt!.hour.toString().padLeft(2, '0')}:${item.createdAt!.minute.toString().padLeft(2, '0')}",
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
                                                                          stepsColor,
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
                                                              Get.to(() =>
                                                                  const SupportRequest());
                                                            },
                                                            child: Container(
                                                              width: 17.w,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15)),
                                                                  color:
                                                                      buttonColor),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            3.w,
                                                                        vertical:
                                                                            0.5.h),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    AutoSizeText(
                                                                      "View",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Work Sans",
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            white,
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
                                ;
                              }),
                            )
                    ]))));
  }

  Widget dialogItem() {
    return SizedBox(
      height: 190,
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
                  height: 3.h,
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
