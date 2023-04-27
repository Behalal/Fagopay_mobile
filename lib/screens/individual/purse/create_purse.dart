// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/individual/purse/my_purse_list.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CreatePurse extends StatefulWidget {
  const CreatePurse({
    super.key,
  });

  @override
  State<CreatePurse> createState() => _CreatePurseState();
}

class _CreatePurseState extends State<CreatePurse> {
  final SfRangeValues _values = const SfRangeValues(2, 3.5);
  double _value = 10000;
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
  int? myRequestType;
  var number = "";
  int? transactionType;

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
                    pageName: "Create a Purse",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText('How much do you plan to spend?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: stepsColor,
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            NameTextfield(
                              // controller: _userController.nameController,
                              title: _value.toString(),
                              keyboadType: TextInputType.number,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Amount must not be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SfSlider(
                              min: 5000,
                              max: 3000000,
                              value: _value,
                              // interval: 20,
                              //  showTicks: true,
                              activeColor: fagoSecondaryColor,
                              inactiveColor: fagoSecondaryColorWithOpacity,
                              showLabels: true,
                              enableTooltip: true,
                              minorTicksPerInterval: 1,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            const AutoSizeText('How long is this budget?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: stepsColor,
                                )),
                            Container(
                              width: Get.width,
                              height: 58,
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: fagoSecondaryColorWithOpacity)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'How long is the budget',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
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
                                  value: selectedAcount,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAcount = value as String;
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
                            SizedBox(
                              height: 2.h,
                            ),
                            const AutoSizeText('Set by categories',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            const Divider(
                              thickness: 1,
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
                                        border: Border.all(
                                            color:
                                                fagoSecondaryColorWithOpacity)),
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
                                            .map((item) =>
                                                DropdownMenuItem<String>(
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
                                            selectedCategories1 =
                                                value as String;
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 40,
                                          width: 140,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
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
                                        border: Border.all(
                                            color:
                                                fagoSecondaryColorWithOpacity)),
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
                                            .map((item) =>
                                                DropdownMenuItem<String>(
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
                                            selectedCategories2 =
                                                value as String;
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 40,
                                          width: 140,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
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
                                        border: Border.all(
                                            color:
                                                fagoSecondaryColorWithOpacity)),
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
                                            .map((item) =>
                                                DropdownMenuItem<String>(
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
                                            selectedCategories3 =
                                                value as String;
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 40,
                                          width: 140,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
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
                              height: 3.h,
                            ),
                            Center(
                              child: AuthButtons(
                                form: false,
                                text: "Save",
                                route: const MyPurseList(),
                              ),
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}
