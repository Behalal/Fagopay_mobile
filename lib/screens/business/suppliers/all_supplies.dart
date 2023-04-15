import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../constants/colors.dart';
import '../../functions.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import '../widgets/boxes.dart';
import '../widgets/load_more.dart';
import 'add_supllies.dart';
import 'supply_details.dart';

class AllSupplies extends StatefulWidget {
  const AllSupplies({super.key});

  @override
  State<AllSupplies> createState() => _AllSuppliesState();
}

class _AllSuppliesState extends State<AllSupplies> {
  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 0,
                pageName: "My Suppliers",
                // backRoute: BusinessHome(
                //   userDetails: _userController.user!,
                //   accountDetails: _userController.userAccountDetails!,
                // ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
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
                                fontWeight: FontWeight.w600),
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
                firstBoxMainValue: "234",
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
              SizedBox(
                height: 60.h,
                child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (var i = 0; i < 10; i++) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                goToPage(context, const SupplyDetails());
                              },
                              child: SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            fagoSecondaryColorWithOpacity10,
                                        child: Image.asset(
                                            "assets/images/gallery.png"),
                                      ),
                                    ),
                                    const AutoSizeText(
                                      "Obasa Yussuf",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 20,
                                          color: inactiveTab,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 4.h,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child:
                                        Image.asset("assets/images/edit.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (i != 9)
                          SizedBox(
                            height: 4.h,
                          ),
                      ]
                    ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LoadMore(),
    );
  }
}
