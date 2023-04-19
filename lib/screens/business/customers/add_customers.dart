import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../widgets/business_form.dart';
import '../../widgets/business_warning.dart';
import '../../widgets/head_style_extra_pages.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                          pageName: "My Customers",
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const BusinessWarning(),
                        SizedBox(
                          height: 3.h,
                        ),
                        const BusinessForm(),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: AuthButtons(
                              form: true, text: "Submit", route: null),
                        )
                      ])))),
    );
  }
}
