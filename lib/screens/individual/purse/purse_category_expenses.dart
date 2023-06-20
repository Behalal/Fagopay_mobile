import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/purse_category_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/custom_date.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PurseCategoryExpenses extends StatefulWidget {
  final String purseCategoryId;
  final String categoryName;
  const PurseCategoryExpenses({Key? key, required this.purseCategoryId, required this.categoryName}) : super(key: key);

  @override
  State<PurseCategoryExpenses> createState() => _PurseCategoryExpensesState();
}

class _PurseCategoryExpensesState extends State<PurseCategoryExpenses> {

  void deleteBottomSheet({required void Function()? onTap, required void Function()? onTap1}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/3.3,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Delete request", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: signInText, fontSize: 22, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 10,),
                  RichText(text: TextSpan(text: "Are you sure to delete this ",
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color(0xff576275), fontSize: 15, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: "Request?", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: signInText, fontSize: 15, fontWeight: FontWeight.w600),)
                    ]
                  ),),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: Container(
                              height: 50,
                              width: Get.width/ 2.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: fagoSecondaryColor,
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  "Continue",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                ),
                              )
                          ),
                        ),
                        InkWell(
                          onTap: onTap1,
                          child: Container(
                              height: 50,
                              width: Get.width/2.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  color: Colors.white, border: Border.all(color: fagoSecondaryColor)
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w600,
                                      color: fagoSecondaryColor),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurseCategoryController>(
      init: PurseCategoryController(),
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.h),
              const ProgressStyle(stage: 0, pageName: "Purse Spending",),
              // const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
              SizedBox(height: 2.h),
              controller.getPurseExpensesResponse == null && controller.onPurseCategoryLoadingState == true ?
                   Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height /3,),
                      const Center(child: CupertinoActivityIndicator(color: fagoSecondaryColor,)),
                      SizedBox(height: MediaQuery.of(context).size.height /3,),
                    ],
                  )
                  : controller.getPurseExpensesResponse == null || controller.getPurseExpensesResponse!.data!.categoryExpenses == [] ||
                  controller.getPurseExpensesResponse!.data!.categoryExpenses!.isEmpty
                      && controller.onPurseCategoryLoadingState == false ?
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
              Column(children: [
                const SizedBox(height: 20,),
                Align(alignment: Alignment.centerLeft,
                  child: Text(widget.categoryName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 22, color: const Color(0xff576275)),),
                ),
                  const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(color: fagoSecondaryColorWithOpacity10, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ...List.generate(controller.getPurseExpensesResponse!.data!.categoryExpenses!.length, (index){
                        return Container(
                          decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/upload.png", height: 40, width: 40,),
                                  const SizedBox(width: 15,),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("#${controller.getPurseExpensesResponse!.data!.categoryExpenses?[index].amountSpend ?? ""}"),
                                      const SizedBox(height: 5,),
                                      Text(CustomDate.slash(controller.getPurseExpensesResponse!.data?.categoryExpenses?[index].createdAt.toString() ?? DateTime.now().toString()),
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 12),)
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  deleteBottomSheet(onTap: (){
                                    Get.back();
                                    controller.deleteExpenses(expensesId: controller.getPurseExpensesResponse!.data!.categoryExpenses![index].id!, context: context);
                                  }, onTap1: (){
                                    Get.back();
                                  });
                                },
                                child: Container(color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/images/delete.png", height: 20, width: 20,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                )
                ],
              )
            ]
          ),
        ),
      );
    });
  }

  final _controller = Get.put(PurseCategoryController());
  @override
  void initState() {
    _controller.getPurseCategory(purseCategoryId: widget.purseCategoryId);
    super.initState();
  }
}
