// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/purse_controller.dart';
import 'package:fagopay/models/purse/createPurse_Model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/individual/purse/my_purse_list.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/foundation.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _pursecontroller = Get.find<PurseController>();
  final SfRangeValues _values = const SfRangeValues(2, 3.5);
  List<CategoryList> categoryList = [];
  List<CategoriesWidget> dynamicList = [];

  List<String> Price = [];

  List<String> Product = [];
  double _value = 10000;
  String? selectedDuration;
  String? selectedCategories1;
  String? selectedCategories2;
  String? selectedCategories3;
  final List<String> items = [
    'weekly',
    'monthly',
    'yearly',
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

  get index => 1;

  @override
  Widget build(BuildContext context) {
    _pursecontroller.getCategorylist();
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
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                    'How much do you plan to spend?',
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
                                  controller: _pursecontroller.budgetController,
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
                                          color:
                                              fagoSecondaryColorWithOpacity)),
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
                                      value: selectedDuration,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDuration = value as String;
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

                                // Obx(() {
                                //   return _pursecontroller.purseCategoryStatus ==
                                //           PurseCategory.loading
                                //       ? const Center(
                                //           child: LoadingWidget(
                                //             color: fagoSecondaryColor,
                                //           ),
                                //         )
                                //       : _pursecontroller
                                //               .purseCategoryList.isNotEmpty
                                //           ? SizedBox(
                                //               height: 300,
                                //               child: ListView.separated(
                                //                   padding: EdgeInsets.zero,
                                //                   scrollDirection:
                                //                       Axis.vertical,
                                //                   physics:
                                //                       const ScrollPhysics(),
                                //                   shrinkWrap: false,
                                //                   itemCount: _pursecontroller
                                //                       .purseCategoryList.length,
                                //                   separatorBuilder:
                                //                       (context, index) =>
                                //                           SizedBox(
                                //                             height: 1.2.h,
                                //                           ),
                                //                   itemBuilder:
                                //                       (context, index) {
                                //                     var item = _pursecontroller
                                //                             .purseCategoryList[
                                //                         index];
                                //                     return InkWell(
                                //                         onTap: () {
                                //                           print('adding...');
                                //                           categoryList.add(CategoryList(
                                //                               amount: '500',
                                //                               categoryId:
                                //                                   _pursecontroller
                                //                                       .purseCategoryList[
                                //                                           index]
                                //                                       .id));

                                //                           // categoryList.add(value);
                                //                           CreatePurseModel
                                //                               createPurseModel =
                                //                               CreatePurseModel(
                                //                             name: "Purse",
                                //                             amount: _pursecontroller
                                //                                 .budgetController
                                //                                 .text
                                //                                 .trim(),
                                //                             duration:
                                //                                 selectedDuration
                                //                                     .toString(),
                                //                             // categories:
                                //                             //     categoryList,
                                //                           );
                                //                           print(
                                //                               'Purse creation is: ${createPurseModel.toJson()}');
                                //                           setState(() {
                                //                             transactionType =
                                //                                 index;
                                //                           });
                                //                           setState(() {
                                //                             transactionType =
                                //                                 index;
                                //                           });
                                //                         },
                                //                         child: Row(
                                //                           children: [
                                //                             Expanded(
                                //                               child: Column(
                                //                                 children: [
                                //                                   AutoSizeText(
                                //                                       item
                                //                                           .categoryName,
                                //                                       textAlign:
                                //                                           TextAlign
                                //                                               .start,
                                //                                       style:
                                //                                           const TextStyle(
                                //                                         fontFamily:
                                //                                             "Work Sans",
                                //                                         fontSize:
                                //                                             16,
                                //                                         fontWeight:
                                //                                             FontWeight.w500,
                                //                                         color:
                                //                                             stepsColor,
                                //                                       )),
                                //                                   AutoSizeText(
                                //                                       item.id,
                                //                                       textAlign:
                                //                                           TextAlign
                                //                                               .start,
                                //                                       style:
                                //                                           const TextStyle(
                                //                                         fontFamily:
                                //                                             "Work Sans",
                                //                                         fontSize:
                                //                                             16,
                                //                                         fontWeight:
                                //                                             FontWeight.w500,
                                //                                         color:
                                //                                             stepsColor,
                                //                                       )),
                                //                                 ],
                                //                               ),
                                //                             ),
                                //                             Expanded(
                                //                               child:
                                //                                   NameTextfield(
                                //                                 controller:
                                //                                     _pursecontroller
                                //                                         .amountController,
                                //                                 title: 'Amount',
                                //                                 keyboadType:
                                //                                     TextInputType
                                //                                         .number,
                                //                                 validate:
                                //                                     (value) {
                                //                                   if (value!
                                //                                       .isEmpty) {
                                //                                     return 'Amount must not be empty';
                                //                                   }
                                //                                   return null;
                                //                                 },
                                //                               ),
                                //                             )
                                //                           ],
                                //                         ));
                                //                   }))
                                //           : Container();
                                // }),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    fagoSecondaryColorWithOpacity)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            hint: Text(
                                              'Categories',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: _pursecontroller
                                                .purseCategoryList
                                                .map((category) =>
                                                    DropdownMenuItem(
                                                      value: category.id,
                                                      child: Text(
                                                        category.categoryName,
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
                                            buttonStyleData:
                                                const ButtonStyleData(
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

                                // SizedBox(
                                //   height: 250,
                                //   child: ListView.builder(
                                //     // physics: ,
                                //     itemExtent: 70.0,
                                //     padding: EdgeInsets.zero,
                                //     itemCount: dynamicList.length,
                                //     itemBuilder: (_, index) =>
                                //         dynamicList[index],
                                //   ),
                                // ),

                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Expanded(
                                //       child: Container(
                                //         width: 3.h,
                                //         height: 58,
                                //         padding: const EdgeInsets.all(12),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(5),
                                //             border: Border.all(
                                //                 color:
                                //                     fagoSecondaryColorWithOpacity)),
                                //         child: DropdownButtonHideUnderline(
                                //           child: DropdownButton2(
                                //             hint: Text(
                                //               'Categories',
                                //               style: TextStyle(
                                //                 fontSize: 14,
                                //                 color:
                                //                     Theme.of(context).hintColor,
                                //               ),
                                //             ),
                                //             items: _pursecontroller
                                //                 .purseCategoryList
                                //                 .map((category) =>
                                //                     DropdownMenuItem<String>(
                                //                       value: category.id,
                                //                       child: Text(
                                //                         category.categoryName,
                                //                         style: const TextStyle(
                                //                           fontSize: 14,
                                //                         ),
                                //                       ),
                                //                     ))
                                //                 .toList(),
                                //             value: selectedCategories2,
                                //             onChanged: (value) {
                                //               setState(() {
                                //                 selectedCategories2 =
                                //                     value as String;
                                //               });
                                //             },
                                //             buttonStyleData:
                                //                 const ButtonStyleData(
                                //               height: 40,
                                //               width: 140,
                                //             ),
                                //             menuItemStyleData:
                                //                 const MenuItemStyleData(
                                //               height: 40,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 1.h,
                                //     ),
                                //     Expanded(
                                //       child: NameTextfield(
                                //         // controller: _userController.nameController,
                                //         title: 'Amount',
                                //         keyboadType: TextInputType.number,
                                //         validate: (value) {
                                //           if (value!.isEmpty) {
                                //             return 'Amount must not be empty';
                                //           }
                                //           return null;
                                //         },
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Expanded(
                                //       child: Container(
                                //         width: 3.h,
                                //         height: 58,
                                //         padding: const EdgeInsets.all(12),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(5),
                                //             border: Border.all(
                                //                 color:
                                //                     fagoSecondaryColorWithOpacity)),
                                //         child: DropdownButtonHideUnderline(
                                //           child: DropdownButton2(
                                //             hint: Text(
                                //               'Categories',
                                //               style: TextStyle(
                                //                 fontSize: 14,
                                //                 color:
                                //                     Theme.of(context).hintColor,
                                //               ),
                                //             ),
                                //             items: _pursecontroller
                                //                 .purseCategoryList
                                //                 .map((category) =>
                                //                     DropdownMenuItem<String>(
                                //                       value: category.id,
                                //                       child: Text(
                                //                         category.categoryName,
                                //                         style: const TextStyle(
                                //                           fontSize: 14,
                                //                         ),
                                //                       ),
                                //                     ))
                                //                 .toList(),
                                //             value: selectedCategories3,
                                //             onChanged: (value) {
                                //               setState(() {
                                //                 selectedCategories3 =
                                //                     value as String;
                                //               });
                                //             },
                                //             buttonStyleData:
                                //                 const ButtonStyleData(
                                //               height: 40,
                                //               width: 140,
                                //             ),
                                //             menuItemStyleData:
                                //                 const MenuItemStyleData(
                                //               height: 40,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 1.h,
                                //     ),
                                //     Expanded(
                                //       child: NameTextfield(
                                //         controller:
                                //             _pursecontroller.amountController,
                                //         title: 'Amount',
                                //         keyboadType: TextInputType.number,
                                //         validate: (value) {
                                //           if (value!.isEmpty) {
                                //             return 'Amount must not be empty';
                                //           }
                                //           return null;
                                //         },
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      add();
                                      print(
                                          'List categorires ${categoryList.length}');
                                      print(
                                          'last categorires ${categoryList.first}');
                                    },
                                    child: Container(
                                      width: 30.w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: buttonColor),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: .8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/fundAccount_icon.svg'),
                                            const AutoSizeText(
                                              "Add Category",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                                color: white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Center(
                                //   child: InkWell(
                                //     onTap: () {
                                //       add();
                                //       print("yesh");
                                //     },
                                //     child: AuthButtons(
                                //       form: true,
                                //       text: "Submit",
                                //       // route: const MyPurseList(),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Obx(() {
                                  return InkWell(
                                    onTap: () {
                                      // Get.to(() => const MyPurseList());
                                      //  add();
                                      CreatePurseModel createPurseModel =
                                          CreatePurseModel(
                                        name: "Purse",
                                        amount: _pursecontroller
                                            .budgetController.text
                                            .trim(),
                                        duration: selectedDuration.toString(),
                                        categories: categoryList,
                                      );

                                      if (kDebugMode) {
                                        print(
                                            'Purse creation is: ${createPurseModel.toJson()}');
                                      }
                                      print('here i am');
                                      if (_pursecontroller
                                                  .purseCategoryStatus !=
                                              CreatePurseEnum.loading &&
                                          formKey.currentState!.validate()) {
                                        print('here i am 3');
                                        _pursecontroller
                                            .createPurse(createPurseModel);
                                      }
                                      print('here i am 2');
                                    },
                                    child: Container(
                                        height: 50,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            color: fagoSecondaryColor),
                                        child: (_pursecontroller
                                                    .purseCategoryStatus ==
                                                CreatePurseEnum.loading)
                                            ? const LoadingWidget()
                                            : const Center(
                                                child: AutoSizeText(
                                                  'Save',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: white,
                                                  ),
                                                ),
                                              )),
                                  );
                                }),
                              ],
                            ),
                          ),
                        )),
                  ),
                ])));
  }

  void add() {
    print("you");
    setState(() {
      categoryList.add(CategoryList(
          amount: _pursecontroller.amountController.text,
          categoryId: _pursecontroller.purseCategoryList[index].id));
    });
  }

  // submitData() {
  //   categoryList = [];
  //   Price = [];
  //   dynamicList
  //       .forEach((widget) => categoryList.add(selectedCategories3.toString()));
  //   dynamicList.forEach((widget) => Price.add(widget.amountController.amountController.text));
  //   setState(() {});
  //   print(Product.length);
  //   //sendData();
  // }

  addDynamic() {
    if (Product.length != 0) {
      // floatingIcon = Icon(Icons.add);

      Product = [];
      Price = [];
      dynamicList = [];
    }
    setState(() {});
    if (dynamicList.length >= 7) {
      return;
    }
    dynamicList.add(const CategoriesWidget());
  }
}

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesWidget> {
  final _pursecontroller = Get.find<PurseController>();
  String? selectedCategories3;
  List<String> Price = [];

  List<String> Product = [];
  @override
  Widget build(BuildContext context) {
    return Row(
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
                items: _pursecontroller.purseCategoryList
                    .map((category) => DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(
                            category.categoryName,
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
            controller: _pursecontroller.amountController,
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
    );
  }
  //  submitData() {
  //   categoryList = [];
  //   Price = [];
  //   dynamicList.forEach((widget) => categoryList.add(widget.selectedCategories3));
  //   dynamicList.forEach((widget) => Price.add(widget.Price.text));
  //   setState(() {});
  //   print(Product.length);
  //   //sendData();
  // }
}
