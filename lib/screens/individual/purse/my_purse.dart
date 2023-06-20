import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/categoryItems.dart';
import 'package:fagopay/models/purse/purse_category_list_response_model.dart';
import 'package:fagopay/models/purse/purse_list_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/individual/purse/create_purse.dart';
import 'package:fagopay/screens/individual/purse/purse_category_expenses.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/purse_controller.dart';
import '../../../functions/constant.dart';
import '../../constants/colors.dart';
import 'package:dio/dio.dart' as dio;

class MyPurse extends StatefulWidget {
  const MyPurse({
    super.key,
  });

  @override
  State<MyPurse> createState() => _MyPurseState();
}

class _MyPurseState extends State<MyPurse> {
  final _purseController = Get.put(PurseController());

  int? myRequestType;
  var number = "";
  int? transactionType;
  List<CategoryItems> categoryItemsList = <CategoryItems>[].obs;
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
      for (var element in pulseCategoryList!) {
        categoryItemsList.add(CategoryItems(categoryId: element.id!, amount: 0));
      }
      await _purseController.purseList();
      await getCategoryList();
      setState(() {});
    });
    for (var element in pulseCategoryList!) {
      categoryItemsList.add(CategoryItems(categoryId: element.id!, amount: 0));
    }
    super.initState();
  }
  int amount = 0;
  int categoryAmount = 0;
  List<CatTesting> itemList =[];

  void recordSpendingBottomSheet({required PulseList pulseList}){
    categoryItemsList.clear();
    itemList.clear();
    for (var element in pulseList.pulseCategories) {
      categoryItemsList.add(CategoryItems(categoryId: element.pulseCategoryId, amount: 0));
    }
    categoryAmount = 0;
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/1.6,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Container(height: 3, width: 80, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(3)),),
              const SizedBox(height: 10,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Record My Spending", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: signInText, fontSize: 22, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 20,),
                  const Divider(thickness: 1),
                  Column(
                    children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText('What’s your spending Today?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: stepsColor,
                              )),
                          AutoSizeText('Amount',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: stepsColor,
                              )),
                        ],
                      ),
                      ...List.generate(pulseList.pulseCategories.length, (i){
                        return ListTile(
                          title: Text(pulseList.pulseCategories[i].categoryName ?? ""),
                          trailing:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  update(() {
                                    if(categoryItemsList[i].amount >=500){
                                      categoryAmount -= 500;
                                      int amountCounter = categoryItemsList[i].amount - 500;
                                      CategoryItems d =  CategoryItems(categoryId: pulseList.pulseCategories[i].pulseCategoryId, amount: amountCounter);
                                      categoryItemsList[categoryItemsList.indexWhere((element) =>
                                      element.categoryId == pulseList.pulseCategories[i].pulseCategoryId)] = d;
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
                                  update(() {
                                    categoryAmount += 500;
                                    int amountCounter = categoryItemsList[i].amount + 500;
                                    CategoryItems d =  CategoryItems(categoryId: pulseList.pulseCategories[i].pulseCategoryId, amount: amountCounter);
                                    categoryItemsList[categoryItemsList.indexWhere((element) =>
                                    element.categoryId == pulseList.pulseCategories[i].pulseCategoryId)] = d;
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
                      }),
                      Divider(height: 0.h, thickness: 1.5,),
                      SizedBox(height: 1.5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text('Total Amount',style: Constant().textStyle(size: 13, weight: FontWeight.w500,color: stepsColor)),
                          //     SizedBox(height: 0.5.h,),
                          //     Text(Constant().formatCurrency.format(double.parse(pulseList.amount)),style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: black)),
                          //   ],
                          // ),
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
                      SizedBox(height: 2.h,),
                      GestureDetector(
                        onTap: () {
                          // if(categoryAmount.toString() != double.parse(pulseList.amount).toInt().toString()){
                          //   Get.snackbar('Error', 'Total amount must be equal to category amount',);
                          // }else{
                            Map? data;
                            for (var element in categoryItemsList) {
                              if(element.amount > 0){
                                setState(() {
                                  itemList.add(CatTesting(categoryId: element.categoryId, amount: element.amount));
                                });
                              }
                              data = {
                                "expenses": itemList
                              };
                            }
                            _purseController.recordExpenses(data!, context).then((value) {
                              var res = value;
                              print(res);
                            });
                          // }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          height: 50, width: double.maxFinite,
                          decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Submit", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 18),)),
                        ),
                      ),

                ],
              ),
            ],
          )]));
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurseController>(
      init: PurseController(),
        builder: (controller){
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 8.h, right: 5.w, left: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 30,),
                  const Spacer(),
                  const AutoSizeText(
                    'My Purse',
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    ),
                  ),
                  const Spacer(),
                  controller.purseListModel == null ||
                      controller.purseListModel!.data.pulseList.isEmpty ||
                      controller.purseListModel!.data.pulseList == [] ? const SizedBox() :
                  GestureDetector(
                    onTap: (){
                      if(controller.purseListModel != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  CreatePurse(isEdit: true, pulseList:
                        controller.purseListModel!.data, purseId: controller.purseListModel?.data.pulseList[0].id,)));
                      }
                    },
                    child: const AutoSizeText(
                      'Edit',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
              SizedBox(
                height: 2.h,
              ),
             controller.purseListModel == null  && controller.onLoadingPurseListLoadingState == true && controller.onLoadPurseListErrorState == false ?
              Center(
                child: LoadingWidget(
                  color: fagoSecondaryColor,
                  size: MediaQuery.of(context).size.height/2.5,
                ),
              ) : controller.purseListModel == null || controller.purseListModel!.data.pulseList.isEmpty || controller.purseListModel!.data.pulseList == [] &&
             controller.onLoadingPurseListLoadingState == false
                  && controller.onLoadPurseListErrorState == false ?
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.5.w),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 3.h,),
                                Container(padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
                                  width: Get.width,
                                  color: fagoSecondaryColorWithOpacity10,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset('assets/icons/purse_icon.svg'),
                                      SizedBox(height: 1.5.h,),
                                      const AutoSizeText(
                                        'No Purse yet',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(height: 2.h,),
                                      const AutoSizeText(
                                        'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const CreatePurse());
                                        },
                                        child: Container(
                                          height: 5.h,
                                          width: 23.5.h,
                                          decoration: BoxDecoration(
                                              color: fagoSecondaryColor,
                                              borderRadius:
                                              BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: fagoSecondaryColor)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const AutoSizeText(
                                                'Create a Purse',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: white,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  'assets/icons/create_wallet.svg')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                              ],
                            )),
                      ),
                    ]),
              )
                  : controller.onLoadingPurseListLoadingState == false
                  && controller.onLoadPurseListErrorState == false
                  && controller.purseListModel != null ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.centerRight,
                      child: Container(
                        width: 190,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(40)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/fund.png", width: 20, height: 20,),
                            const SizedBox(width: 7,),
                            GestureDetector(
                              onTap: (){
                                recordSpendingBottomSheet(pulseList: controller.purseListModel!.data.pulseList[0]);
                              },
                              child: const Text(
                                'Record Spending',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(color: fagoSecondaryColorWithOpacity10, borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.purseListModel?.data.pulseList[0].name ?? "", style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 10, fontWeight: FontWeight.w300),),
                                  Text(Constant().formatCurrency.format(double.parse(controller.purseListModel?.data.pulseList[0].amount ?? "0")), style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 17, fontWeight: FontWeight.w700),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(controller.purseListModel?.data.pulseList[0].duration ?? ""),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Divider(),
                          const SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Amount Spent", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 10, fontWeight: FontWeight.w300),),
                                  Text(Constant().formatCurrency.format(double.parse(controller.purseListModel?.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toString()  ?? "0")), style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 18, fontWeight: FontWeight.w700),)
                                ],
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Amount left to spend", style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 10, fontWeight: FontWeight.w300),),
                                  double.parse("${double.parse(controller.purseListModel!.data.pulseList[0].amount)-controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble()}") > 0.00 ?
                                  Text(Constant().formatCurrency.format(double.parse("${double.parse(controller.purseListModel!.data.pulseList[0].amount)-controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble()}")), style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 18, fontWeight: FontWeight.w700),) :
                                  Text(Constant().formatCurrency.format(double.parse("0")), style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 18, fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble() == 0.0 ?
                          const LinearProgressIndicator(backgroundColor: Colors.white, value: 0) :
                          LinearProgressIndicator(backgroundColor: Colors.white,
                              value: controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble()/
                                  double.parse(controller.purseListModel!.data.pulseList[0].amount)),

                          double.parse("${double.parse(controller.purseListModel!.data.pulseList[0].amount)-controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble()}") < 0.00 ?
                          Align(alignment: Alignment.centerRight,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 8,),
                                Text("In excess of", style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 10, fontWeight: FontWeight.w300),),
                                Text(Constant().formatCurrency.format(double.parse("${double.parse(controller.purseListModel!.data.pulseList[0].amount)-controller.purseListModel!.data.pulseList[0].pulseCategories.map((e) => e.amountSpend).toList().reduce((a, b) => (a+b)).toDouble()}")), style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 18, fontWeight: FontWeight.w700),)
                              ],
                            ),
                          )   : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Monthly Budget',style: Constant().textStyle(size: 14, weight: FontWeight.w400,color: black)),
                        Text('Spent',style: Constant().textStyle(size: 14, weight: FontWeight.w400,color: black)),
                      ],
                    ),
                        controller.purseListModel!.data.pulseList[0].pulseCategories.isEmpty ||
                        controller.purseListModel?.data.pulseList[0].pulseCategories == [] ||
                        controller.purseListModel?.data.pulseList[0].pulseCategories == null ?
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 100,),
                          CircleAvatar(
                            radius: 40, backgroundColor: fagoSecondaryColor.withOpacity(0.1),
                              child: Center(child: Image.asset("assets/images/empty-folder.png", height: 60, width: 60,))),
                          const SizedBox(height: 10,),
                          Text("No Expenses Recorded Yet", style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 14, fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ) :
                        ListView.builder(
                          itemCount:  controller.purseListModel?.data.pulseList[0].pulseCategories.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,i){
                            var dataB =  controller.purseListModel?.data.pulseList[0].pulseCategories[i];
                            return Column(
                              children: [
                                const SizedBox(height: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> PurseCategoryExpenses(purseCategoryId: dataB!.pulseCategoryId.toString(), categoryName: dataB.categoryName,));
                                  },
                                  child: Container(
                                    color: Colors.white, width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset("assets/images/wallet.png", height: 40, width: 40,),
                                            const SizedBox(width: 10,),
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dataB?.categoryName ?? "",
                                                  style: Constant().textStyle(size: 13, weight: FontWeight.w300,color: black),
                                                ),
                                                const SizedBox(height: 5,),
                                                Text("${Constant().formatCurrency.format(double.parse(dataB?.budgetedAmount ?? "0"),)} budgeted",
                                                  style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          Constant().formatCurrency.format(double.parse(dataB?.amountSpend.toString() ?? "0"),),
                                          style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: fagoSecondaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(color: fagoSecondaryColorWithOpacity10, width: double.maxFinite, height: 1,)
                              ],
                            );
                          },
                        ),
                  ],
                ),
              ) :  Center(
                child: LoadingWidget(
                  color: fagoSecondaryColor,
                  size: MediaQuery.of(context).size.height/2.5,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
