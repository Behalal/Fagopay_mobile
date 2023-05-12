import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/company_controller.dart';
import '../../../controllers/customers_controller.dart';
import '../../../controllers/sales_controller.dart';
import '../../../models/customer_model.dart';
import '../customers/add_customer.dart';
import '../../widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../widgets/customer_details.dart';

class AddSalesOrExpenses extends StatefulWidget {
  const AddSalesOrExpenses({super.key});

  @override
  State<AddSalesOrExpenses> createState() => _AddSalesOrExpensesState();
}

class _AddSalesOrExpensesState extends State<AddSalesOrExpenses> {
  bool salesTab = true;

  final _customerController = Get.find<CustomerController>();
  final _salesController = Get.find<SalesController>();
  final _companyController = Get.find<CompanyController>();

  String selectedCustomerId = "";
  String selectedPaymentStatus = "";

  List supplierList = [
    {'name': 'Select Customer', 'value': ''},
    {'name': 'Customer1', 'value': 'dhd'},
    {'name': 'Customer2', 'value': 'gha'}
  ]; // Option 2
  String? selectedSupplier;

  List categoryList = [
    {'name': 'Select Category', 'value': ''},
    {'name': 'Category 1', 'value': '1'},
  ]; // Option 2
  String? selectedCategory;

  String? paymentType;

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1959, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    getCustomers();
    super.initState();
  }

  @override
  void dispose() {
    _salesController.salesAmountController.clear();
    _salesController.amountPaidController.clear();
    _salesController.salesDescriptionController.clear();
    super.dispose();
  }

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
              ProgressStyle(
                stage: 0,
                pageName: (salesTab) ? "Add Sales" : "Add Expenses",
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!salesTab) {
                          salesTab = !salesTab;
                        }
                      });
                    },
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (salesTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: AutoSizeText(
                          "Sales",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                (salesTab) ? fagoSecondaryColor : inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        if (salesTab) {
                          salesTab = !salesTab;
                        }
                      });
                    }),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (!salesTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: AutoSizeText(
                          "Expenses",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                (!salesTab) ? fagoSecondaryColor : inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              if (salesTab) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText(
                      "Enter Transaction Amount",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: welcomeText,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: "Enter Transaction Amount",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Select Customer",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DropdownButtonFormField(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: linearGradient1,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter country",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                      value: (selectedCustomer == '') ? null : selectedCustomer,
                      hint: const Text("Select customer"),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedCustomer = value;
                          } else {
                            selectedCustomer = "";
                          }
                        });
                      },
                      items: customer.map((country) {
                        return DropdownMenuItem<String>(
                          value: country['value'],
                          child: Text(country['name']),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: inactiveTab,
                        ),
                        children: [
                          TextSpan(
                            text: 'If customer does not exist yet, ',
                          ),
                          TextSpan(
                            text: 'click here ',
                            style: TextStyle(
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'to add',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Customer",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: fagoSecondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          width: 4.w,
                        ),
                        SizedBox(
                          width: 70.w,
                          child: const AutoSizeText(
                            "Obasa Yussuf",
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Payment Status",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DropdownButtonFormField(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: linearGradient1,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter country",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                      value: (selectedCustomer == '') ? null : selectedCustomer,
                      hint: const Text("Select customer"),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedCustomer = value;
                          } else {
                            selectedCustomer = "";
                          }
                        });
                      },
                      items: customer.map((country) {
                        return DropdownMenuItem<String>(
                          value: country['value'],
                          child: Text(country['name']),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Sales Date",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.5.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: textBoxBorderColor,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: signInPlaceholder,
                              ),
                            ),
                            Image.asset(
                              "assets/images/arrow-down.png",
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Sales Description",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: welcomeText,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: "Customer bought a pair of shoe",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (!salesTab) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText(
                      "Enter Transaction Amount",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: welcomeText,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: "Enter Transaction Amount",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "What is the payment for?",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: RadioListTile(
                            activeColor: fagoBlackColor,
                            selectedTileColor: fagoBlackColor,
                            dense: false,
                            value: "male",
                            groupValue: paymentType,
                            onChanged: (value) {
                              setState(() {
                                paymentType = value.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: RadioListTile(
                            activeColor: fagoBlackColor,
                            selectedTileColor: fagoBlackColor,
                            value: "female",
                            groupValue: paymentType,
                            onChanged: (value) {
                              setState(() {
                                paymentType = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: const AutoSizeText(
                            "Payment to Supplier",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: fagoBlackColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: const AutoSizeText(
                            "Others",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: fagoBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Supplier Details",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: fagoSecondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    const BusinessCustomerDetails(),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Select Category",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DropdownButtonFormField(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: linearGradient1,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Select Category",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                      value: (selectedCategory == '') ? null : selectedCategory,
                      hint: const Text("Select customer"),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedCategory = value;
                          } else {
                            selectedCategory = "";
                          }
                        });
                      },
                      items: categoryList.map((country) {
                        return DropdownMenuItem<String>(
                          value: country['value'],
                          child: Text(country['name']),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Sales Date",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.5.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: textBoxBorderColor,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: signInPlaceholder,
                              ),
                            ),
                            Image.asset(
                              "assets/images/arrow-down.png",
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Notes",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: welcomeText,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: "Share anything about the transaction",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(
                height: 4.h,
              ),
              Center(
                  child: AuthButtons(
                text: "Submit",
                form: true,
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createBusinessSales(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();

    final companyId = _companyController.company!.id!;
    final response = await _salesController.createBusinessSales(
      companyId: companyId,
      customerId: selectedCustomerId,
      salesAmount: _salesController.salesAmountController.text,
      amountPaid: _salesController.amountPaidController.text,
      paymentStatus: selectedPaymentStatus,
      salesDate: selectedDate.toString(),
      salesDescription: _salesController.salesDescriptionController.text,
    );

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      progress.dismiss();
      if (!mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Sales Created Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    progress.dismiss();
    Fluttertoast.showToast(
      msg: "${jsonBody['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
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

enum PaymentStatus { notPaid, partPaid, fullyPaid }

extension Status on PaymentStatus {
  String get title {
    switch (this) {
      case PaymentStatus.notPaid:
        return 'Not Paid';
      case PaymentStatus.partPaid:
        return 'Part Paid';
      case PaymentStatus.fullyPaid:
        return 'Fully Paid';
      default:
        return '';
    }
  }

  String get value {
    switch (this) {
      case PaymentStatus.notPaid:
        return '0';
      case PaymentStatus.partPaid:
        return '1';
      case PaymentStatus.fullyPaid:
        return '2';
      default:
        return '';
    }
  }
}
