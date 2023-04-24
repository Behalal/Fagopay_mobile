import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/suppliers_controller.dart';
import 'package:fagopay/models/supplier_model.dart';
import 'package:fagopay/screens/business/suppliers/components/custom_supplier_card.dart';
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

  @override
  void initState() {
    getSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: RefreshIndicator(
            onRefresh: getSuppliers,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProgressStyle(
                      stage: 0,
                      pageName: "My Suppliers",
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            goToPage(
                              context,
                              const AddSupplies(),
                            );
                          },
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            decoration: const BoxDecoration(
                                color: fagoSecondaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/add_grp.png"),
                                SizedBox(
                                  width: 1.5.w,
                                ),
                                const AutoSizeText(
                                  "Add Supplier",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomerBox(
                      firstBoxImage: "assets/images/customers.png",
                      secondBoxImage: "assets/images/no_of_transaction_box.png",
                      firstBoxDescription: "No. of Customers",
                      firstBoxMainValue:
                          _supplierController.suppliers.length.toString(),
                      secondBoxMainValue: "234",
                      secondBoxDescription: "Total Transaction Value",
                      boxBackground: fagoGreenColorWithOpacity10,
                      textImageColor: fagoGreenColor,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AutoSizeText(
                            "My Suppliers",
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          Image.asset(
                            "assets/images/search.png",
                            color: fagoGreenColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    _supplierController.suppliers.isEmpty
                        ? SizedBox(
                            height: 20.h,
                            child: const Center(
                                child: AutoSizeText('No suppliers yet')),
                          )
                        : SizedBox(
                            height: 60.h,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: _supplierController.suppliers.length,
                              itemBuilder: (context, index) =>
                                  CustomSupplierCard(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SupplyDetails(),
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
                          ),
                  ],
                ),
              ),
            ),
          ),
          // bottomNavigationBar: const LoadMore(),
        ));
  }

  Future<void> getSuppliers() async {
    final response = await _supplierController.getSuppliers();
    final resBody = response['data']['suppliers_list'];
    final returnedSuppliers = resBody
        .map<Supplier>((supplier) => Supplier.fromJson(supplier))
        .toList();
    setState(() {
      _supplierController.suppliers = returnedSuppliers;
    });
  }
}
