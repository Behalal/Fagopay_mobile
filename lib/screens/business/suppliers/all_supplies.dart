import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import '../../../controllers/company_controller.dart';
import '../../../controllers/suppliers_controller.dart';
import '../../../models/supplier_model.dart';
import 'components/custom_supplier_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../functions.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../widgets/boxes.dart';
import 'add_supplier.dart';
import 'supply_details.dart';

class AllSupplies extends StatefulWidget {
  const AllSupplies({super.key});

  @override
  State<AllSupplies> createState() => _AllSuppliesState();
}

class _AllSuppliesState extends State<AllSupplies> {
  final _supplierController = Get.find<SupplierController>();
  final _companyController = Get.find<CompanyController>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    getSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getSuppliers,
      child: GetBuilder<SupplierController>(
        // init: SupplierController(),
          builder: (controller){
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "My Suppliers",
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         goToPage(
                  //           context,
                  //           const AddSupplies(),
                  //         );
                  //       },
                  //       child: Container(
                  //         alignment: AlignmentDirectional.centerEnd,
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 4.w, vertical: 1.h),
                  //         decoration: const BoxDecoration(
                  //             color: fagoSecondaryColor,
                  //             borderRadius: BorderRadius.all(Radius.circular(25))),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Image.asset("assets/images/add_grp.png"),
                  //             SizedBox(
                  //               width: 1.5.w,
                  //             ),
                  //             const AutoSizeText(
                  //               "Add Supplier",
                  //               style: TextStyle(
                  //                 fontFamily: "Work Sans",
                  //                 fontSize: 10,
                  //                 color: white,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: 43.w, height: 42.w,
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                          decoration: const BoxDecoration(color: fagoGreenColorWithOpacity10,),
                          child:  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4.h,
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                    child: Image.asset("assets/images/group_supplier.png"),
                                  ),
                                ),
                                // SizedBox(height: 1.5.h,),
                                AutoSizeText(_supplierController?.suppliers?.length.toString()?? "0.0",
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 28,
                                      color: fagoGreenColor,
                                      fontWeight: FontWeight.w700),
                                ),
                                // SizedBox(height: 1.5.h,),
                                const AutoSizeText(
                                  "No. of Suppliers",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                              ])),
                      GestureDetector(
                        onTap: (){
                          goToPage(context, const AddSupplies(),);
                        },
                        child: Container(width: 43.w, height: 42.w,
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                            decoration: const BoxDecoration(color: fagoGreenColorWithOpacity10,),
                            child:  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 4.h,
                                    child: const CircleAvatar(
                                      backgroundColor: white,
                                      child: Icon(Icons.add, color: fagoGreenColor,),
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h,),
                                  const FittedBox(
                                    child: AutoSizeText(
                                      "Add Supplier",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12, color: inactiveTab,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ])),
                      )
                    ],
                  ),
                  // CustomerBox(
                  //   firstBoxImage: "assets/images/customers.png",
                  //   secondBoxImage: "assets/images/no_of_transaction_box.png",
                  //   firstBoxDescription: "No. of Customers",
                  //   firstBoxMainValue:
                  //   _supplierController.suppliers.length.toString(),
                  //   secondBoxMainValue: "234",
                  //   secondBoxDescription: "Total Transaction Value",
                  //   boxBackground: fagoGreenColorWithOpacity10,
                  //   textImageColor: fagoGreenColor,
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "My Suppliers",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                        // Image.asset(
                        //   "assets/images/search.png",
                        //   color: fagoGreenColor,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  controller.isLoadingSuppliers == true ? Center(child: LoadingWidget(color: fagoSecondaryColor,size: MediaQuery.of(context).size.height / 4)) :
                  controller.isLoadingSuppliers  == false && controller.suppliers.isEmpty ?
                  SizedBox(height: 20.h, child: const Center(
                      child: AutoSizeText('You don\'t any supplier yet')),
                  ) : controller.isLoadingSuppliers  == false  && controller.suppliers.isNotEmpty || controller.suppliers != [] ? SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _supplierController.suppliers.length,
                      itemBuilder: (context, index) => CustomSupplierCard(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SupplyDetails(supplierId: _supplierController.suppliers[index].id.toString(),),
                              settings: RouteSettings(
                                arguments: _supplierController
                                    .suppliers[index].id!,
                              ),
                            ),
                          );
                        },
                        supplierName:
                        _supplierController.suppliers[index].name!,
                      ),
                    ),
                  ) : Center(child: LoadingWidget(color: fagoSecondaryColor, size: MediaQuery.of(context).size.height / 4,)),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: const LoadMore(),
        );
      }),
    );
  }

  Future<void> getSuppliers() async {
    await _supplierController.getSuppliers(companyId: _companyController.company!.id!);
  }
}
