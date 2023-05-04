import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../invoice/add_invoice.dart';

class SelectCustomer extends StatefulWidget {
  final TextEditingController controller;
  const SelectCustomer({super.key, required this.controller});

  @override
  State<SelectCustomer> createState() => _SelectCustomerState();
}

class _SelectCustomerState extends State<SelectCustomer> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 60.h,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 1.h,
            ),
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: fagoSecondaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          const Center(
            child: AutoSizeText(
              "Select Customer",
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: fagoSecondaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 1.5.h,
            ),
            decoration: const BoxDecoration(
              color: fagoSecondaryColorWithOpacity10,
            ),
            child: InvoiceField(
              hintText: "Search Customer by name",
              controller: widget.controller,
              bgColor: true,
              txtColor: true,
              textWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.5.h),
            height: 40.h,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < 5; i++) ...[
                  SizedBox(
                    width: 90.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 4.w,
                                backgroundColor:
                                    fagoSecondaryColorWithOpacity10,
                                child: Image.asset(
                                  "assets/images/gallery.png",
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: const AutoSizeText(
                                        "Obasa Yussuf",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            color: inactiveTab,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: const AutoSizeText(
                                        "obasana@gmail.com",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 12,
                                            color: inactiveTab,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            AutoSizeText(
                              "Select",
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  color: fagoSecondaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
