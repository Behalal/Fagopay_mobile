import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/customers_controller.dart';
import 'package:fagopay/screens/business/customers/add_customers.dart';
import 'package:fagopay/screens/business/customers/components/custom_customer_card.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:get/get.dart';
import '../widgets/boxes.dart';
import '../../constants/colors.dart';
import 'customer_details.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final _customerController = Get.find<CustomerController>();

  @override
  void initState() {
    getCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "My Customers",
            ),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
              onTap: () => goToPage(context, const AddCustomer()),
              // getCustomers();

              child: Padding(
                padding: EdgeInsets.only(left: 53.w, right: 2.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                        "Add Customer",
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
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomerBox(
              firstBoxImage: "assets/images/customers.png",
              secondBoxImage: "assets/images/biz_transactions.png",
              firstBoxDescription: "No. of Customers",
              firstBoxMainValue: "234",
              secondBoxMainValue: "234",
              secondBoxDescription: "Total Transaction Value",
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeText(
                  "My Favorite Customers",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      color: inactiveTab,
                      fontWeight: FontWeight.w500),
                ),
                Image.asset("assets/images/tranactions.png")
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) => CustomCustomerCard(
                  fullName: 'Obasa',
                  email: 'o@gmail.com',
                  phoneNumber: '0908765567',
                  onPressed: () {
                    goToPage(context, const CustomerDetails());
                  },
                ),
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: const LoadMore(),
    );
  }

  void getCustomers() async {
    final response = await _customerController.getCustomers();
    print(response);
  }
}
