// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../functions.dart';

class CustomSupplierCard extends StatelessWidget {
  const CustomSupplierCard({
    Key? key,
    required this.onPressed,
    required this.supplierName,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String supplierName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 4.h,
                  child: CircleAvatar(
                    backgroundColor: fagoSecondaryColorWithOpacity10,
                    child: Image.asset("assets/images/gallery.png"),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: 65.w,
                  child: AutoSizeText(
                    capitalize(supplierName),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 20,
                        color: inactiveTab,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
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
                  child: Image.asset("assets/images/edit.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
