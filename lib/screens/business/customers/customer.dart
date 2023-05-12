import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/customers_controller.dart';
import '../../../models/customer_model.dart';
import '../../constants/colors.dart';
import '../../functions.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../widgets/boxes.dart';
import 'add_customer.dart';
import 'components/custom_customer_card.dart';
import 'customer_details.dart';

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
    return Obx(
      () => Scaffold(
        body: RefreshIndicator(
          onRefresh: getCustomers,
          child: Padding(
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 53.w, right: 2.w),
                    child: Container(
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
                  firstBoxImage: "assets/images/people.svg",
                  secondBoxImage: "assets/images/archive-book.svg",
                  firstBoxDescription: "No. of Customers",
                  firstBoxMainValue:
                      _customerController.customers.length.toString(),
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
                    SvgPicture.asset("assets/images/document-filter.svg"),
                  ],
                ),
                _customerController.customers.isEmpty
                    ? SizedBox(
                        height: 20.h,
                        child: const Center(
                            child: AutoSizeText('No customers yet')),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          // itemCount: 3,
                          itemCount: _customerController.customers.length,
                          itemBuilder: (context, index) => CustomCustomerCard(
                            // fullName: "Korede",
                            fullName: _customerController.customers[index].fullname!,
                            // email: "akored@gmail.com",
                            email: _customerController.customers[index].email!,
                            // phoneNumber: "080976543445",
                            phoneNumber: _customerController.customers[index].phoneNumber!,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CustomerDetails(),
                                  settings: RouteSettings(
                                    arguments: _customerController
                                        .customers[index].id!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const LoadMore(),
      ),
    );
  }

  Future<void> getCustomers() async {
    final response = await _customerController.getCustomers();
    final resBody = response['data']['customers'];
    final returnedCustomers = resBody
        .map<Customer>((customer) => Customer.fromJson(customer))
        .toList();
    setState(() {
      _customerController.customers = returnedCustomers;
    });
  }
}
