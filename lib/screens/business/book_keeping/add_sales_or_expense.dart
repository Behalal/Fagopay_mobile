import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/expenses_controller.dart';
import 'package:fagopay/controllers/suppliers_controller.dart';
import 'package:fagopay/models/expenses_model.dart';
import 'package:fagopay/models/supplier_model.dart';
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

class AddSalesOrExpenses extends StatefulWidget {
  const AddSalesOrExpenses({super.key});

  @override
  State<AddSalesOrExpenses> createState() => _AddSalesOrExpensesState();
}

class _AddSalesOrExpensesState extends State<AddSalesOrExpenses> {
  bool salesTab = true;

  final _customerController = Get.find<CustomerController>();
  final _supplierController = Get.find<SupplierController>();
  final _salesController = Get.find<SalesController>();
  final _companyController = Get.find<CompanyController>();
  final _expensesContoller = Get.find<ExpensesController>();
  List<ExpenseCategory> expenseCategories = [];

  String selectedCustomerId = "";
  String selectedSupplierId = "";
  String selectedPaymentStatus = "";
  String selectedExpenseCategoryId = "";

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
    getSuppliers();
    getBusinessExpenseCategories();
    super.initState();
  }

  @override
  void dispose() {
    _salesController.salesAmountController.clear();
    _salesController.amountPaidController.clear();
    _salesController.salesDescriptionController.clear();
    // _expensesContoller.expenseAmountController.clear();
    _expensesContoller.expenseReasonController.clear();
    _expensesContoller.expenseDescriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                                  color: (salesTab)
                                      ? fagoSecondaryColor
                                      : inactiveTab,
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
                                  color: (!salesTab)
                                      ? fagoSecondaryColor
                                      : inactiveTab,
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
                            "Enter Sales Amount",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: welcomeText,
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              controller:
                                  _salesController.salesAmountController,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: linearGradient1,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                            height: 0.5.h,
                          ),
                          CustomDropdownButton(
                            hint: 'Select Customer',
                            items: _customerController.customers
                                .map(
                                  (customer) => DropdownMenuItem(
                                    value: customer.id,
                                    child: Text(customer.fullname!),
                                  ),
                                )
                                .toList(),
                            onChanged: (selectedValue) {
                              if (selectedValue != null) {
                                setState(() {
                                  selectedCustomerId = selectedValue;
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddCustomer(),
                              ),
                            ),
                            child: RichText(
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
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          // const AutoSizeText(
                          //   "Customer",
                          //   style: TextStyle(
                          //     fontFamily: "Work Sans",
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w400,
                          //     color: fagoSecondaryColor,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 1.5.h,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     SizedBox(
                          //       height: 4.h,
                          //       child: CircleAvatar(
                          //         backgroundColor: fagoSecondaryColorWithOpacity10,
                          //         child: Image.asset("assets/images/gallery.png"),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 4.w,
                          //     ),
                          //     SizedBox(
                          //       width: 70.w,
                          //       child: const AutoSizeText(
                          //         "Obasa Yussuf",
                          //         style: TextStyle(
                          //             fontFamily: "Work Sans",
                          //             fontSize: 16,
                          //             color: inactiveTab,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
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
                            height: 0.5.h,
                          ),
                          CustomDropdownButton(
                            hint: 'Select status',
                            items: PaymentStatus.values
                                .map((status) => DropdownMenuItem(
                                      value: status.value,
                                      child: Text(
                                        status.title,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (selectedValue) {
                              if (selectedValue != null) {
                                setState(() {
                                  selectedPaymentStatus = selectedValue;
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const AutoSizeText(
                            "Enter Amount Paid",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: welcomeText,
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              controller: _salesController.amountPaidController,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: linearGradient1,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                            "Sales Date",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: welcomeText,
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            height: 0.5.h,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              controller:
                                  _salesController.salesDescriptionController,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: linearGradient1,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                          // const AutoSizeText(
                          //   "Enter Transaction Amount",
                          //   style: TextStyle(
                          //     fontFamily: "Work Sans",
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w400,
                          //     color: welcomeText,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 0.5.h,
                          // ),
                          // SizedBox(
                          //   width: 90.w,
                          //   child: TextFormField(
                          //     controller:
                          //         _expensesContoller.expenseAmountController,
                          //     style: const TextStyle(
                          //       fontFamily: "Work Sans",
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 14,
                          //       color: welcomeText,
                          //     ),
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 4.w,
                          //         vertical: 1.h,
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5.0),
                          //         borderSide: const BorderSide(
                          //           color: textBoxBorderColor,
                          //           width: 1.0,
                          //         ),
                          //       ),
                          //       focusedBorder: const OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5)),
                          //         borderSide: BorderSide(
                          //           color: linearGradient1,
                          //           width: 1.0,
                          //           style: BorderStyle.solid,
                          //         ),
                          //       ),
                          //       border: const OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5)),
                          //         borderSide: BorderSide(
                          //           color: textBoxBorderColor,
                          //           width: 1.0,
                          //           style: BorderStyle.solid,
                          //         ),
                          //       ),
                          //       hintText: "Enter Transaction Amount",
                          //       hintStyle: const TextStyle(
                          //         fontFamily: "Work Sans",
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 14,
                          //         color: signInPlaceholder,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          const AutoSizeText(
                            "Expense Category",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: welcomeText,
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          CustomDropdownButton(
                            hint: 'Select Category',
                            items: expenseCategories
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category.id,
                                    child: Text(category.categoryName!),
                                  ),
                                )
                                .toList(),
                            onChanged: (selectedValue) {
                              if (selectedValue != null) {
                                setState(() {
                                  selectedExpenseCategoryId = selectedValue;
                                });
                              }
                            },
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
                                  value: "suppliers",
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
                                  value: "others",
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
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // const AutoSizeText(
                          //   "Supplier Details",
                          //   style: TextStyle(
                          //     fontFamily: "Work Sans",
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w400,
                          //     color: fagoSecondaryColor,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 1.5.h,
                          // ),
                          // const BusinessCustomerDetails(),
                          SizedBox(
                            height: 2.h,
                          ),
                          // if (paymentType == null || paymentType == 'suppliers')

                          paymentType != null && paymentType == 'others'
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const AutoSizeText(
                                      "Enter Reason",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: welcomeText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                      child: TextFormField(
                                        controller: _expensesContoller
                                            .expenseReasonController,
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                              color: textBoxBorderColor,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: linearGradient1,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: textBoxBorderColor,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          hintText: "Enter reason",
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
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const AutoSizeText(
                                      "Select Supplier",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: welcomeText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    CustomDropdownButton(
                                      hint: 'Select Supplier',
                                      items: _supplierController.suppliers
                                          .map(
                                            (supplier) => DropdownMenuItem(
                                              value: supplier.id,
                                              child: Text(supplier.name!),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (selectedValue) {
                                        if (selectedValue != null) {
                                          setState(() {
                                            selectedSupplierId = selectedValue;
                                          });
                                        }
                                      },
                                    ),
                                  ],
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
                            height: 0.5.h,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            height: 0.5.h,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              controller: _expensesContoller
                                  .expenseDescriptionController,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: linearGradient1,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                hintText:
                                    "Share anything about the transaction",
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
                      child: GestureDetector(
                        onTap: () async {
                          if (salesTab) {
                            if (_salesController.salesAmountController.text !=
                                    "" &&
                                selectedCustomerId != "" &&
                                selectedPaymentStatus != "" &&
                                _salesController.amountPaidController.text !=
                                    "" &&
                                selectedDate.toString() != "" &&
                                _salesController
                                        .salesDescriptionController.text !=
                                    "") {
                              await createBusinessSales(context);
                              return;
                            }
                            Fluttertoast.showToast(
                              msg: "Fill in the form properly!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            return;
                          }
                          if (_expensesContoller
                                      .expenseDescriptionController.text !=
                                  "" &&
                              selectedDate.toString() != "" &&
                              selectedExpenseCategoryId != "") {
                            await createBusinessExpense(context);
                            return;
                          }
                          Fluttertoast.showToast(
                            msg: "Fill in the form properly!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: AuthButtons(
                          text: "Submit",
                          form: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

  Future<void> createBusinessExpense(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();

    final companyId = _companyController.company!.id!;
    final response = await _expensesContoller.createBusinessExpense(
      companyId: companyId,
      supplierId: selectedSupplierId,
      reason: _expensesContoller.expenseReasonController.text,
      expenseCategory: selectedExpenseCategoryId,
      expenseDate: selectedDate.toString(),
      note: _expensesContoller.expenseDescriptionController.text,
    );

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      progress.dismiss();
      if (!mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Expense Created Successfully",
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

  Future<void> getBusinessExpenseCategories() async {
    final response = await _expensesContoller.getBusinessExpenseCategories();
    final jsonBody = response['data']['category_list'];
    final returnedCategories = jsonBody
        .map<ExpenseCategory>(
            (expenseCategory) => ExpenseCategory.fromJson(expenseCategory))
        .toList();
    setState(() {
      expenseCategories = returnedCategories;
    });
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