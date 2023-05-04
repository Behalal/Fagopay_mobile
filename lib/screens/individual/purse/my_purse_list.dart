// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/controllers/purse_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/individual/purse/purse_spending.dart';
import 'package:fagopay/screens/individual/requests/payme_page.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../authentication/recover_password_otp_screen.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyPurseList extends StatefulWidget {
  const MyPurseList({
    super.key,
  });

  @override
  State<MyPurseList> createState() => _MyPurseListState();
}

class _MyPurseListState extends State<MyPurseList> {
  final _pursecontroller = Get.find<PurseController>();
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    _pursecontroller.showPurse('6f1a604f-69c0-458c-a524-d8c014722fa0');
    _pursecontroller.purseDurationlist('8ebe6b44-2968-4560-ab6a-7e0e87287baf');
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "My Purse",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          const RecordSpending(),
                                    );
                                  },
                                  child: Container(
                                    width: 45.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: buttonColor),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: .9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          // SvgPicture.asset(
                                          //     'assets/icons/record_spending_wallet.svg'),
                                          AutoSizeText(
                                            "Record Spending",
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.h, vertical: 3.h),
                                height: 21.h,
                                width: Get.width,
                                color: fagoPrimaryColorWithOpacity10,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const AutoSizeText(
                                                    'My purse budget',
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: stepsColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  _pursecontroller.userPurse
                                                              .value?.amount !=
                                                          null
                                                      ? AutoSizeText(
                                                          _pursecontroller
                                                                  .userPurse
                                                                  .value
                                                                  ?.amount ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                "Work Sans",
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: stepsColor,
                                                          ),
                                                        )
                                                      : const AutoSizeText(
                                                          "No Budget Amount",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Work Sans",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: welcomeText,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Container(
                                                height: 2.5.h,
                                                width: 8.5.h,
                                                decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  _pursecontroller.userPurse
                                                          .value?.duration
                                                          .toUpperCase() ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          AutoSizeText(
                                            'Amount Spent',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              color: stepsColor,
                                            ),
                                          ),
                                          AutoSizeText(
                                            'Amount left to spend',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              color: stepsColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          AutoSizeText(
                                            'NGN 380,000.00',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: fagoSecondaryColor,
                                            ),
                                          ),
                                          AutoSizeText(
                                            'NGN 120,000.00',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: fagoSecondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const LinearProgressIndicator(
                                          value: 0.7,
                                          minHeight: 3,
                                          color: fagoSecondaryColor,
                                          backgroundColor:
                                              fagoPrimaryColorWithOpacity10
                                          // valueColor: AlwaysStoppedAnimation<Color>(
                                          //   AppColor().loadingGreen,
                                          // ),
                                          ),
                                    ])),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AutoSizeText(
                                      _pursecontroller.userPurse.value?.duration
                                              .toUpperCase() ??
                                          '',
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    const AutoSizeText(
                                      ' Budget',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const AutoSizeText(
                                  'Spent',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: stepsColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Obx(() {
                              return _pursecontroller.showPurseStatus ==
                                      ShowPurseEnum.loading
                                  ? const LoadingWidget(
                                      color: fagoSecondaryColor,
                                    )
                                  : _pursecontroller
                                          .purseDurationList.isNotEmpty
                                      ? SizedBox(
                                          height: 60,
                                          child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: false,
                                              itemCount: _pursecontroller
                                                  .purseDurationList.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        height: 1.2.h,
                                                      ),
                                              itemBuilder: (context, index) {
                                                var item = _pursecontroller
                                                    .purseDurationList[index];
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.h),
                                                  height: 6.h,
                                                  width: Get.width,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icons/reffered_list_icon.svg',
                                                        ),
                                                        SizedBox(
                                                          width: 2.h,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              item.amount,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Work Sans",
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    stepsColor,
                                                              ),
                                                            ),
                                                            const AutoSizeText(
                                                              'NGN 38,000.00 budgeted',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Work Sans",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    stepsColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const AutoSizeText(
                                                          'NGN 20,000.00',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Work Sans",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                fagoSecondaryColor,
                                                          ),
                                                        ),
                                                      ]),
                                                );
                                              }),
                                        )
                                      : Container();
                            }),
                            SizedBox(
                              height: 1.h,
                            ),
                            const Divider(
                              color: stepsColor,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 1.h),
                            //   height: 6.h,
                            //   width: Get.width,
                            //   child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         SvgPicture.asset(
                            //           'assets/icons/reffered_list_icon.svg',
                            //         ),
                            //         SizedBox(
                            //           width: 2.h,
                            //         ),
                            //         Column(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: const [
                            //             AutoSizeText(
                            //               'Food and Drinks',
                            //               style: TextStyle(
                            //                 fontFamily: "Work Sans",
                            //                 fontSize: 10,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: stepsColor,
                            //               ),
                            //             ),
                            //             AutoSizeText(
                            //               'NGN 38,000.00 budgeted',
                            //               style: TextStyle(
                            //                 fontFamily: "Work Sans",
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w600,
                            //                 color: stepsColor,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         const Spacer(),
                            //         const AutoSizeText(
                            //           'NGN 20,000.00',
                            //           style: TextStyle(
                            //             fontFamily: "Work Sans",
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w700,
                            //             color: fagoSecondaryColor,
                            //           ),
                            //         ),
                            //       ]),
                            // ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}

class RecordSpending extends StatefulWidget {
  const RecordSpending({super.key});

  @override
  State<RecordSpending> createState() => _RecordSpendingState();
}

class _RecordSpendingState extends State<RecordSpending> {
  String? selectedAcount;
  String? selectedCategories1;
  String? selectedCategories2;
  String? selectedCategories3;
  final List<String> items = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Yearly',
  ];
  final List<String> categories1 = [
    'Transport',
    'Feeding',
    'Cloths',
    'Data',
  ];
  final List<String> categories2 = [
    'Transport',
    'Feeding',
    'Cloths',
    'Data',
  ];
  final List<String> categories3 = [
    'Transport',
    'Feeding',
    'Cloths',
    'Data',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
      child: SizedBox(
        height: 50.h,
        child: Column(children: [
          Container(
            height: 0.4.h,
            width: 10.h,
            color: fagoSecondaryColor,
          ),

          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            'Record My Spending',
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          const Divider(
            color: stepsColor,
          ),
          // ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AutoSizeText(
                'What’s your spending about?',
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: stepsColor,
                ),
              ),
              SizedBox(
                width: 3.5.h,
              ),
              const AutoSizeText(
                'Amount',
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: stepsColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 3.h,
                  height: 58,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: fagoSecondaryColorWithOpacity)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: categories1
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedCategories1,
                      onChanged: (value) {
                        setState(() {
                          selectedCategories1 = value as String;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.h,
              ),
              Expanded(
                child: NameTextfield(
                  // controller: _userController.nameController,
                  title: 'Amount',
                  keyboadType: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Amount must not be empty';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 3.h,
                  height: 58,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: fagoSecondaryColorWithOpacity)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: categories2
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedCategories2,
                      onChanged: (value) {
                        setState(() {
                          selectedCategories2 = value as String;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.h,
              ),
              Expanded(
                child: NameTextfield(
                  // controller: _userController.nameController,
                  title: 'Amount',
                  keyboadType: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Amount must not be empty';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 3.h,
                  height: 58,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: fagoSecondaryColorWithOpacity)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: categories3
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedCategories3,
                      onChanged: (value) {
                        setState(() {
                          selectedCategories3 = value as String;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.h,
              ),
              Expanded(
                child: NameTextfield(
                  // controller: _userController.nameController,
                  title: 'Amount',
                  keyboadType: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Amount must not be empty';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: AuthButtons(
              form: false,
              text: "Submit",
              route: const PurseSpending(),
            ),
          ),
        ]),
      ),
    );
  }
}
