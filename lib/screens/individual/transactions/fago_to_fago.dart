import '../widgets/account_details.dart';
import '../widgets/head_style_extra_pages.dart';
import '../widgets/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FagoToFago extends StatefulWidget {
  const FagoToFago({super.key});

  @override
  State<FagoToFago> createState() => _FagoToFagoState();
}

class _FagoToFagoState extends State<FagoToFago> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 5.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressStyle(
                stage: 50,
                pageName: "Fago P2P",
                // backRoute: const DashboardHome(),
              ),
              SizedBox(
                height: 2.h,
              ),
              AccountDetails(
                action: "spend",
                accountDetails: const {},
              ),
              SizedBox(
                height: 2.h,
              ),
              FagoTransactionForm(
                page: "phone",
                cancelRoute: const FagoToFago(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
