import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../individual/widgets/business_form.dart';
import '../../individual/widgets/business_warning.dart';
import '../../individual/widgets/head_style_extra_pages.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
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
                      stage: 50,
                      width: 4,
                      pageName: "My Supplies",
                      // backRoute: CustomerPage(),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const BusinessWarning(),
                    SizedBox(
                      height: 2.h,
                    ),
                    const BusinessForm(),
                    SizedBox(height: 4.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AuthButtons(
                          form: true, text: "Submit", route: null),
                    )
                  ]
              )
          )
      )
    );
  }
}
