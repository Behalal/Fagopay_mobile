import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/purse_controller.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/models/categoryItems.dart';
import 'package:fagopay/models/purse/createPurse_Model.dart';
import 'package:fagopay/models/purse/purse_category_list_response_model.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/widgets/drop_down_field.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../models/purse/purse_list_model.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;

class CreatePurse extends StatefulWidget {
    final  PurseListData ?pulseList;
    final bool ?isEdit;
    final String? purseId;
  const CreatePurse({super.key,this.pulseList,this.isEdit = false, this.purseId});

  @override
  State<CreatePurse> createState() => _CreatePurseState();
}

class _CreatePurseState extends State<CreatePurse> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _pursecontroller = Get.put(PurseController());
  final SfRangeValues _values = const SfRangeValues(2, 3.5);
  List<CategoryItems> categoryItemsList = <CategoryItems>[].obs;
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List<String> Price = [];
  List<String> Product = [];
  double _value = 10000;
  String? selectedDuration;
  String? purseId;
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
  bool? onPurseCategoryListLoadingState;
  bool? onPurseCategoryListErrorState;
  List<PulseCategoryList>? pulseCategoryList = <PulseCategoryList>[].obs;

  Future<void> getCategoryList() async {
    onPurseCategoryListLoadingState = true;
    onPurseCategoryListErrorState = false;
    setState(() {});
    try {
      final response = await NetworkProvider().call(path: "/v1/pulsecategory", method: RequestMethod.get);
      final payload = PurseCategoryListResponse.fromJson(response?.data);
      pulseCategoryList = payload.data?.pulseCategoryList;
      onPurseCategoryListLoadingState = false;
      onPurseCategoryListErrorState = false;
    }on dio.DioError catch (err) {
      onPurseCategoryListLoadingState = false;
      onPurseCategoryListErrorState = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (error) {
      if (error.toString() == "KYC Not yet verified") {
        pulseCategoryList = [];
        onPurseCategoryListLoadingState = false;
        onPurseCategoryListErrorState = false;
        setState(() {});
        Get.snackbar('Error', 'Go and verify your KYC in other to be able to perform transactions');
      }else{
        onPurseCategoryListLoadingState = false;
        onPurseCategoryListErrorState = true;
        setState(() {});
        Get.snackbar('Error', error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'" ? 'No internet connection!' : error.toString());
      }
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.isEdit!){
        amountController.text = widget.pulseList!.pulseList[0].amount;
        nameController.text = widget.pulseList!.pulseList[0].name;
        selectedDuration = widget.pulseList!.pulseList[0].duration;
        purseId = widget.pulseList!.pulseList[0].id;
        setState(() {});
      }
      for (var element in pulseCategoryList!) {
        categoryItemsList.add(CategoryItems(categoryId: element.id!, amount: 0));
      }
      await getCategoryList();
      setState(() {});
    });
    super.initState();
  }
  int amount = 0;
 showBottomSheetForDelete({required String purseId}){
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
           child:  Column(
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
                             text: 'Are you sure to delete this purse Request?',
                             style:  Constant().textStyle(size: 15, weight: FontWeight.w700,color: stepsColor),
                         ),
                       ]),
                   )
               ),
               SizedBox(height: 2.h,),
               Row(
                 children: [
                   Expanded(
                     child: GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                         _pursecontroller.deletePurse(purseId: purseId, context: context);
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
           )
       );
     },
     isScrollControlled: true,
   );
 }
  List<int> num =[];
  List<CatTesting> itemList =[];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurseController>(
      init: PurseController(),
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Image(image: AssetImage("assets/images/Icon.png")),
                      iconSize: 20,
                    ),
                    SizedBox(
                      width: 50.w,
                      child: const Text("Create a Purse",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(onTap: (){
                      showBottomSheetForDelete(purseId: widget.purseId!);
                    }, child: Image.asset("assets/images/delete_new.png", height: 25, width: 25,)),
                  ],
                ),
                Container(height: 2, decoration: const BoxDecoration(color: fagoSecondaryColorWithOpacity,
                      borderRadius: BorderRadius.all(Radius.circular(10))),),
                SizedBox(height: 2.h),
                const SizedBox(height: 30,),
                Text('Enter Purse Name',style: Constant().textStyle(size: 12.5, weight: FontWeight.w500,color: stepsColor),),
                SizedBox(height: 1.h,),
                TextFormField(
                  keyboardType:  TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Purse name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
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
                        borderSide: BorderSide(color: linearGradient1, width: 1.0, style: BorderStyle.solid)),
                    hintText:  "Purse name",
                    hintStyle: const TextStyle(
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: stepsColor,
                    ),
                    //prefixIcon: const Image(image: AssetImage("assets/images/phone.png")),
                  ),
                  controller: nameController,
                ),
                SizedBox(height: 2.h,),
                Text('How much do you plan to spend?', style: Constant().textStyle(size: 12.5, weight: FontWeight.w500,color: stepsColor),),
                SizedBox(height: 1.h,),
                TextFormField(
                  keyboardType:  TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Amount must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {});
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
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
                  ),
                  controller: amountController,
                ),
                SizedBox(height: 2.5.h),
                const AutoSizeText('How long is this budget?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: stepsColor,
                    )),
                SizedBox(height: 1.h,),
                DropDownTextField(
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value as String;
                    });
                  },
                  items: items.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                  )).toList(),
                  title: selectedDuration ?? "Select budget duration",
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
                SizedBox(height: 0.h),
                onPurseCategoryListLoadingState == true &&  onPurseCategoryListErrorState == false && pulseCategoryList!.isEmpty || pulseCategoryList == []?
                SizedBox(height: MediaQuery.of(context).size.height/2.6,
                  child: const Center(
                      child: CupertinoActivityIndicator(color: fagoSecondaryColor,)),
                ): Column(
                  children: [
                    ...List.generate(pulseCategoryList!.length, (i){
                      for (var element in pulseCategoryList!) {
                        categoryItemsList.add(CategoryItems(categoryId: element.id!, amount: 0));
                      }
                      return ListTile(
                        title: Text(pulseCategoryList?[i].categoryName ?? ""),
                        trailing:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  if(categoryItemsList[i].amount >=500){
                                    categoryAmount -= 500;
                                    int amountCounter = categoryItemsList[i].amount - 500;
                                    CategoryItems d =  CategoryItems(categoryId: pulseCategoryList![i].id!, amount: amountCounter);
                                    categoryItemsList[categoryItemsList.indexWhere((element) =>
                                    element.categoryId == pulseCategoryList![i].id)] = d;
                                  }
                                });
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
                            Text(Constant().formatCurrency.format(double.parse(categoryItemsList[i].amount.toString())),
                              style: Constant().textStyle(size: 16, weight: FontWeight.w500,color: black),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  categoryAmount += 500;
                                  int amountCounter = categoryItemsList[i].amount + 500;
                                  CategoryItems d =  CategoryItems(categoryId: pulseCategoryList![i].id!, amount: amountCounter);
                                  categoryItemsList[categoryItemsList.indexWhere((element) =>
                                  element.categoryId == pulseCategoryList![i].id)] = d;
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
                    })
                  ],
                ),
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
                GestureDetector(
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      if(selectedDuration == null){
                        Get.snackbar('Error', 'Select duration to proceed');
                      }else if(  categoryItemsList.isEmpty){
                        Get.snackbar('Error', 'Add Categories to proceed');
                      }else if(categoryAmount.toString() != double.parse(amountController.text).toInt().toString()){
                        Get.snackbar('Error', 'Total amount must be equal to category amount',);
                      } else{
                        Map? data;
                        for (var element in categoryItemsList) {
                          if(element.amount > 0){
                            setState(() {
                              itemList.add(CatTesting(categoryId: element.categoryId, amount: element.amount));
                            });
                          }
                          data = {
                            "categories": itemList,
                            "name": nameController.text.trim(),
                            "amount": double.parse(amountController.text).toInt().toString(),
                            "duration": selectedDuration,
                          };
                        }
                        log(itemList.length.toString());
                        setState(() {
                          isLoading = true;
                        });
                        widget.isEdit == true ? controller.editPurse(data!, context, purseId!).then((value) {
                          var res = value;
                          print(res);
                          if(res?.data ! == null){
                            setState(() {
                              isLoading = false;
                            });
                          }else {
                            Navigator.pop(context);
                          }
                        }) :
                        controller.createPurse(data!, context).then((value) {
                          var res = value;
                          print(res);
                          if(res?.data ! == null){
                            setState(() {
                              isLoading = false;
                            });
                          }else {
                            Navigator.pop(context);
                          }
                        });
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 50, width: double.maxFinite,
                    decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Save", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 18),)),
                  ),
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      );
    });
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
