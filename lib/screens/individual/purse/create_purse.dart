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
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/purse/purse_category.dart';
import '../../../models/purse/purse_list_model.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert';

class CreatePurse extends StatefulWidget {
    final  PurseListData ?pulseList;
    final bool ?isEdit;
  const CreatePurse({super.key,this.pulseList,this.isEdit = false});

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
  TextEditingController nameController = TextEditingController();

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

  int? myRequestType;
  var number = "";
  int? transactionType;
  bool isLoading = false;
  get index => 1;
  int listIndex =1;
  int categoryAmount = 0;
  @override
  void initState() {
    if(widget.isEdit!){
      amountController.text = widget.pulseList!.pulseList[0].amount;
      nameController.text = widget.pulseList!.pulseList[0].name;
      selectedDuration = widget.pulseList!.pulseList[0].duration;
    }
    _pursecontroller.getCategorylist();
    super.initState();
  }
  int amount = 0;
  @override
  void dispose() {
    _pursecontroller.purseCategoryList.clear();
    categoryItemsListController.categoryItemsList.value.clear();
    categoryItemsListController.categoryItemsList.value.clear();
    _pursecontroller.budgetController.clear();
    super.dispose();
  }
  List<int> num =[];
  List<CatTesting> itemList =[];
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
                  SizedBox(height: 2.h),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Enter Purse Name',style: Constant().textStyle(size: 12.5, weight: FontWeight.w500,color: stepsColor),),
                                SizedBox(height: 1.h,),
                                NameTextfield(
                                  controller: nameController,
                                  title: 'Enter Purse name',
                                  keyboadType: TextInputType.number,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Purse Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 2.h,),
                                Text('How much do you plan to spend?',style: Constant().textStyle(size: 12.5, weight: FontWeight.w500,color: stepsColor),),
                                SizedBox(height: 1.h,),
                                TextFormField(
                                  keyboardType:  TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Amount must not be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (s){
                                    setState(() {

                                    });
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                         color:  fagoSecondaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: textBoxBorderColor,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: linearGradient1,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    hintText:  _value.toString(),
                                    hintStyle: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: stepsColor,
                                    ),
                                    //prefixIcon: const Image(image: AssetImage("assets/images/phone.png")),
                                  ),
                                  controller: amountController,
                                ),

                               // SizedBox(height: 1.h),
                                // SfSlider(
                                //   min: 5000,
                                //   max: 3000000,
                                //   value: _value,
                                //   // interval: 20,
                                //   //  showTicks: true,
                                //   activeColor: fagoSecondaryColor,
                                //   inactiveColor: fagoSecondaryColorWithOpacity,
                                //   showLabels: true,
                                //   enableTooltip: true,
                                //   minorTicksPerInterval: 1,
                                //   onChanged: (dynamic value) {
                                //     final formattedValue = formatCurrency.format(value);
                                //
                                //     setState(() {
                                //       amountController.value = amountController.value.copyWith(
                                //         text: formattedValue.split('.')[0],
                                //         selection: TextSelection.collapsed(offset: formattedValue.length),
                                //       );
                                //       // _pursecontroller.budgetController.text = value.toString().split('.')[0];
                                //        _value = value;
                                //       // _pursecontroller.budgetController.value = _pursecontroller.budgetController.value.copyWith(
                                //       //   text: formattedValue.split('.')[0],
                                //       //   selection: TextSelection.collapsed(offset: formattedValue.length),
                                //       // );
                                //     });
                                //   },
                                // ),
                                SizedBox(height: 2.5.h),
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
                                      border: Border.all(color: fagoSecondaryColorWithOpacity)),
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
                                              )).toList(),
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
                                SizedBox(height: 1.h),
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
                                SizedBox(height: 0.h),
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
                                Obx(() {
                                  return _pursecontroller.purseCategoryStatus == PurseCategoryEnum.loading? const Center(child: LoadingWidget(color: fagoSecondaryColor,)): MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _pursecontroller.purseCategoryList.length,
                                        itemBuilder: (context,i){
                                        //  Iterable<PulseCategory> data =  widget.pulseList!.pulseList[0].pulseCategories.where((element) => element.categoryName ==  _pursecontroller.purseCategoryList[i].categoryName);
                                         // widget.pulseList!.pulseList[0].pulseCategories.contains(_pursecontroller.purseCategoryList[i].categoryName);
                                          _pursecontroller.addDefaultItems(10);
                                          return ListTile(
                                            title: Text(_pursecontroller.purseCategoryList[i].categoryName),
                                            //  subtitle: Text(itemList[i].amount.toString()),
                                            trailing:  Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    if(categoryItemsListController.categoryItemsList.value[i].amount >=500){
                                                      categoryAmount -= 500;
                                                      int amountCounter = categoryItemsListController.categoryItemsList.value[i].amount - 500;
                                                      CategoryItems d =  CategoryItems(categoryId: _pursecontroller.purseCategoryList[i].id, amount: amountCounter);
                                                      setState(() {
                                                        categoryItemsListController.categoryItemsList.value[categoryItemsListController.categoryItemsList.value.indexWhere((element) =>
                                                        element.categoryId == _pursecontroller.purseCategoryList[i].id)] = d;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(
                                                            color: stepsColor
                                                        )
                                                    ),
                                                    child: const Icon(Icons.remove,color: fagoSecondaryColor,),
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(Constant().formatCurrency.format(double.parse(categoryItemsListController.categoryItemsList.value[i].amount.toString())),
                                                  style: Constant().textStyle(size: 16, weight: FontWeight.w500,color: black),
                                                ),
                                                SizedBox(width: 2.w),
                                                GestureDetector(
                                                  onTap: (){
                                                    categoryAmount += 500;
                                                    int amountCounter = categoryItemsListController.categoryItemsList.value[i].amount + 500;
                                                    CategoryItems d =  CategoryItems(categoryId: _pursecontroller.purseCategoryList[i].id, amount: amountCounter);
                                                    setState(() {
                                                      categoryItemsListController.categoryItemsList.value[categoryItemsListController.categoryItemsList.value.indexWhere((element) =>
                                                      element.categoryId == _pursecontroller.purseCategoryList[i].id)] = d;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(
                                                            color: stepsColor
                                                        )
                                                    ),
                                                    child: const Icon(Icons.add,color: fagoGreenColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          // return ;
                                        }),
                                  );
                                }),
                                Divider(
                                  height: 0.h,
                                  thickness: 1.5,
                                ),
                                SizedBox(height: 1.5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Amount',style: Constant().textStyle(size: 13, weight: FontWeight.w500,color: stepsColor)),
                                        SizedBox(height: 0.5.h,),
                                        Text(Constant().formatCurrency.format(double.parse(amountController.text.isEmpty?'0':amountController.text)),style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: black)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Category Amount',style: Constant().textStyle(size: 13, weight: FontWeight.w500,color: stepsColor)),
                                        SizedBox(height: 0.5.h,),
                                        Text(Constant().formatCurrency.format(double.parse(categoryAmount.toString())),style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: black)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.5.h,),
                                isLoading?const Center(child: const LoadingWidget(color: fagoPrimaryColor)):Constant().longBtn(radius: 30,color: fagoSecondaryColor,text: 'Save',tap:() {
                                  if(formKey.currentState!.validate()){
                                    if(selectedDuration == null){
                                      Get.snackbar('Error', 'Select Category to proceed');
                                    }else if(  categoryItemsListController.categoryItemsList.value.isEmpty){
                                      Get.snackbar('Update', 'Add Categories to proceed');
                                    }else   if(categoryAmount != int.parse(amountController.text)){
                                      Get.snackbar('Error', 'Total amount must be equal to category amount',backgroundColor: fagoSecondaryColor,colorText: white);
                                    }
                                    else{
                                      Map ?data;
                                      categoryItemsListController.categoryItemsList.value.forEach((element) {
                                        if(element.amount > 0){
                                          setState(() {
                                            //    categoryAmount += element.amount;
                                            itemList.add(CatTesting(categoryId: element.categoryId, amount: element.amount));
                                          });
                                        }
                                         data = {
                                          "categories": itemList,
                                          "name": nameController.text.trim(),
                                          "amount": int.parse(amountController.text),
                                          "duration": selectedDuration,
                                        };
                                      });
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _pursecontroller.createPurse(data!).then((value) {
                                        var res = jsonDecode(value);
                                        print(res);
                                        if(res['data']['code'] == 409){
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }else if(res['data']['code'] == 200){
                                          Navigator.pop(context);
                                        }
                                      });
                                    }
                                  }
                                  },
                                ),
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
