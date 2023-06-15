// ignore_for_file: unrelated_type_equality_checks

import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/purse_controller.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/models/categoryItems.dart';
import 'package:fagopay/models/purse/createPurse_Model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/purse/purse_category.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert';

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
  final categoryItemsListController = Get.find<PurseController>();
  final SfRangeValues _values = const SfRangeValues(2, 3.5);
  List<CategoryList> categoryList = [];
  TextEditingController amountController = TextEditingController();
  List<CategoriesWidget> dynamicList = [];

  List<String> Price = [];
  PulseCategoryList ?cat;
  List<String> Product = [];
  double _value = 10000;
  String? selectedDuration;
  String? selectedCategories1 ;
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
  List<String> itemString = [];
  int? myRequestType;
  var number = "";
  int? transactionType;

  get index => 1;
  int listIndex =1;
  @override
  void initState() {
    _pursecontroller.getCategorylist();
    super.initState();
  }
  int amount = 0;
  @override
  void dispose() {
    _pursecontroller.budgetController.clear();
    super.dispose();
  }
  List<int> num =[];
  List<CatTesting> itemList =[];

  @override
  Widget build(BuildContext context) {
    print(_pursecontroller.purseCategoryList[0].id);
    int nairaSymbolCodePoint = 0x20A6;
    String nairaSymbol = String.fromCharCode(nairaSymbolCodePoint);
    final formatCurrency =  NumberFormat.currency(locale: 'en_US', symbol: nairaSymbol);
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
                  SizedBox(height: 2.h),
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
                                    final formattedValue = formatCurrency.format(value);

                                    setState(() {
                                      // _pursecontroller.budgetController.text = value.toString().split('.')[0];
                                       _value = value;
                                      _pursecontroller.budgetController.value = _pursecontroller.budgetController.value.copyWith(
                                        text: formattedValue.split('.')[0],
                                        selection: TextSelection.collapsed(offset: formattedValue.length),
                                      );
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
                                      items: items.map((item) =>
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
                                SizedBox(height: 2.h),
                                const Divider(thickness: 1),
                              //  Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Expanded(
                              //       flex: 4,
                              //       child: Container(
                              //         width: 3.h,
                              //         height: 58,
                              //         padding: const EdgeInsets.all(12),
                              //         decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(5),
                              //             border: Border.all(color: fagoSecondaryColorWithOpacity)),
                              //         child: DropdownButton<PulseCategoryList>(
                              //           hint: Text(
                              //             'Categories',
                              //             style: TextStyle(
                              //               fontSize: 14,
                              //               color:
                              //               Theme.of(context).hintColor,
                              //             ),
                              //           ),
                              //           items: _pursecontroller.purseCategoryList.map((category) => DropdownMenuItem<PulseCategoryList>(
                              //             value: category,
                              //             child: Text(
                              //               category.categoryName,
                              //               style: const TextStyle(
                              //                 fontSize: 14,
                              //               ),
                              //             ),
                              //           )).toList(),
                              //           value: cat,
                              //           onChanged: (value) {
                              //             setState(() {
                              //               selectedCategories1 = value?.categoryName;
                              //             });
                              //             print(value);
                              //           },
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 1.h,
                              //     ),
                              //     Expanded(
                              //       flex: 2,
                              //       child: NameTextfield(
                              //         controller: amountController,
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
                                SizedBox(height: 2.h),
                                // Center(
                                //   child: InkWell(
                                //     onTap: () {
                                //       setState(() {
                                //         itemString.add(selectedCategories1!);
                                //         itemList.add(CatTesting(amount: int.parse(amountController.text),categoryId: '5g512b58-47f9-4df1-02a8-506820f97605'));
                                //         amountController.clear();
                                //       });
                                //       print('catlist = ${itemList.length}');
                                //     },
                                //     child: Container(
                                //       width: 30.w,
                                //       decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: buttonColor),
                                //       child: Padding(
                                //         padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .8.h),
                                //         child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             SvgPicture.asset('assets/icons/fundAccount_icon.svg'),
                                //             const AutoSizeText(
                                //               "Add Category",
                                //               style: TextStyle(
                                //                 fontFamily: "Work Sans",
                                //                 fontSize: 8,
                                //                 fontWeight: FontWeight.w600,
                                //                 color: white,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                GetBuilder<PurseController>(
                                  builder: (s) => ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _pursecontroller.purseCategoryList.length,
                                      itemBuilder: (context,i){
                                        return ListTile(
                                          title: Text(_pursecontroller.purseCategoryList[i].categoryName),
                                          //  subtitle: Text(itemList[i].amount.toString()),
                                          trailing:  Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.remove),
                                              SizedBox(width: 1.5.w),
                                             Text(categoryItemsListController.categoryItemsList.value[i].amount.toString()),
                                              SizedBox(width: 1.5.w),
                                              GestureDetector(
                                                  onTap: (){
                                                    int amountCounter = categoryItemsListController.categoryItemsList.value[i].amount + 500;
                                                    CategoryItems d =  CategoryItems(categoryId: _pursecontroller.purseCategoryList[i].id, amount: amountCounter);

                                                    categoryItemsListController.categoryItemsList.value[categoryItemsListController.categoryItemsList.value.indexWhere((element) =>
                                                    element.categoryId == _pursecontroller.purseCategoryList[i].id)] = d;

                                                    print(categoryItemsListController.categoryItemsList.value[i].categoryId);
                                                    print(categoryItemsListController.categoryItemsList.value[i].amount);

                                                  },
                                                  child: Icon(Icons.add)),
                                            ],
                                          ),
                                        );
                                        // return ;
                                      }),
                                ),
                                SizedBox(height: 2.h),
                                Obx(() {
                                  return InkWell(
                                    onTap: () {
                                      print('SENDING TO SERVER');

                                          categoryItemsListController.categoryItemsList.value.forEach((element) {
                                            if(element.amount > 0){
                                              itemList.add(CatTesting(categoryId: element.categoryId, amount: element.amount));
                                            }
                                          });

                                          itemList.forEach((element) {
                                            print(itemList);
                                            print("${element.categoryId}, ${element.amount}");
                                          });
                                      // var data = {
                                      //   "categories": itemList,
                                      //   "name": "Testing from app",
                                      //   "amount": "2000",
                                      //   "duration": "weekly"
                                      // };
                                      // if (kDebugMode) {
                                      //   print('Purse creation is: $data');
                                      // }
                                      // print('here i am');
                                      // if (_pursecontroller.purseCategoryStatus != CreatePurseEnum.loading && formKey.currentState!.validate()) {
                                      //   print('here i am 3');
                                      //   _pursecontroller.createPurse(data);
                                      // }
                                      // print('here i am 2');
                                    },
                                    child: Container(
                                        height: 50,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(36),
                                            color: fagoSecondaryColor),
                                        child: (_pursecontroller.purseCategoryStatus == CreatePurseEnum.loading)
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
                ],
            ),
        ),
    );
  }

  contanier({required IconData icon,required Color iconColor, required Color borderColor,required bool isActive,required VoidCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
                color: isActive?  fagoSecondaryColor: borderColor
            )
        ),
        child: Icon(icon,color: isActive?  fagoSecondaryColor: iconColor,),
      ),
    );
  }

  void add() {
    print("you");
    setState(() {
      categoryList.add(CategoryList(
          amount: _pursecontroller.amountController.text,
          categoryId: _pursecontroller.purseCategoryList[index].id));
    });
  }
  ///Old drop down code
  // row({required String categoryString,required int index, VoidCallback? iconTap}){
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Expanded(
  //         child: Container(
  //           width: 3.h,
  //           height: 58,
  //           padding: const EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //               border: Border.all(color: fagoSecondaryColorWithOpacity)),
  //           child: DropdownButton<String>(
  //             items: <String>['A', 'B', 'C', 'D'].map((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               );
  //             }).toList(),
  //             onChanged: (_) {},
  //           ),
  //           // DropdownButtonHideUnderline(
  //           //   child: DropdownButton(
  //           //     hint: Text(
  //           //       'Categories',
  //           //       style: TextStyle(
  //           //         fontSize: 14,
  //           //         color:
  //           //         Theme.of(context).hintColor,
  //           //       ),
  //           //     ),
  //           //     items: _pursecontroller.purseCategoryList.map((category) => DropdownMenuItem(
  //           //           value: category.id,
  //           //           child: Text(
  //           //             category.categoryName,
  //           //             style: const TextStyle(
  //           //               fontSize: 14,
  //           //             ),
  //           //           ),
  //           //         )).toList(),
  //           //      value: categoryString,
  //           //     onChanged: (value) {
  //           //       setState(() {
  //           //         categoryString = value as String;
  //           //       });
  //           //     },
  //           //     // buttonStyleData:
  //           //     // const ButtonStyleData(
  //           //     //   height: 40,
  //           //     //   width: 140,
  //           //     // ),
  //           //     // menuItemStyleData: const MenuItemStyleData(
  //           //     //   height: 40,
  //           //     // ),
  //           //   ),
  //           // ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 1.h,
  //       ),
  //       Expanded(
  //         child: NameTextfield(
  //           // controller: _userController.nameController,
  //           title: 'Amount',
  //           keyboadType: TextInputType.number,
  //           validate: (value) {
  //             if (value!.isEmpty) {
  //               return 'Amount must not be empty';
  //             }
  //             return null;
  //           },
  //         ),
  //       ),
  //      // index == 1?Container(): Expanded(
  //      //      child: GestureDetector(
  //      //          onTap: iconTap,
  //      //          child: Icon(Icons.remove)),
  //      //  ),
  //     ],
  //   );
  // }

///
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
    if (Product.isNotEmpty) {
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

CatTesting catTestingFromJson(String str) => CatTesting.fromJson(json.decode(str));

String catTestingToJson(CatTesting data) => json.encode(data.toJson());

class CatTesting {
  String categoryId;
  int amount;

  CatTesting({
    required this.categoryId,
    required this.amount,
  });

  factory CatTesting.fromJson(Map<String, dynamic> json) => CatTesting(
    categoryId: json["category_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "amount": amount,
  };
}
