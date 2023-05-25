import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/business/invoice/components/invoice_field.dart';
import 'package:fagopay/screens/business/invoice/components/invoice_item_details_card.dart';
import 'package:fagopay/screens/business/invoice/components/order_item_button.dart';
import 'package:fagopay/screens/business/invoice/components/remove_item.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../controllers/company_controller.dart';
import '../../../controllers/customers_controller.dart';
import '../../../controllers/invoice_controller.dart';
import '../../../models/customer_model.dart';
import '../../widgets/custom_dropdown_field.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/head_style_extra_pages.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  final _customerController = Get.find<CustomerController>();
  final _invoiceController = Get.find<InvoiceController>();
  final _companyController = Get.find<CompanyController>();
  List<Map<String, String>> temporarilyAddedItems = [];
  // TextEditingController taxCalcController = TextEditingController();
  // TextEditingController discountCalcController = TextEditingController();

  String selectedCustomerId = "";
  double taxAmount = 0;
  double dicountAmount = 0;

  @override
  void initState() {
    getCustomers();
    super.initState();
  }

  @override
  void dispose() {
    _invoiceController.discountRateController.clear();
    _invoiceController.itemNameController.clear();
    _invoiceController.priceController.clear();
    _invoiceController.quantityController.clear();
    _invoiceController.taxRateController.clear();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();
  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(1959, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // List<double> detailTotals = temporarilyAddedItems.map((item) {
    //   return double.parse(item['quantity']!) * double.parse(item['price']!);
    // }).toList();
    // double detailTotal = detailTotals.reduce((a, b) => a + b);
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
                    const ProgressStyle(
                      stage: 0,
                      pageName: "Add Invoice",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5, color: fagoBlackColorWithOpacity15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 45.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "Invoice No.",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: inactiveTab,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const AutoSizeText(
                                  "#INV124560",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: inactiveTab,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 45.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const AutoSizeText(
                                  "Choose Due Date",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: inactiveTab,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: inactiveTab,
                                    ),
                                    SizedBox(width: 0.7.w),
                                    GestureDetector(
                                      // onTap: () => selectDate(context),
                                      child: AutoSizeText(
                                        // "${selectedDate.toLocal()}".split(' ')[0],
                                        Jiffy.parse(selectedDate.toString())
                                            .format(pattern: 'dd/MM/yyyy'),
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: inactiveTab,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    // const AutoSizeText(
                    //   "Business Detail",
                    //   style: TextStyle(
                    //     fontFamily: "Work Sans",
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w400,
                    //     color: welcomeText,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                    //   decoration: const BoxDecoration(
                    //     color: fagoSecondaryColorWithOpacity10,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       CircleAvatar(
                    //         radius: 3.w,
                    //         backgroundColor: fagoSecondaryColorWithOpacity10,
                    //         child: Image.asset(
                    //           "assets/images/gallery.png",
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 2.w,
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             width: 70.w,
                    //             child: const AutoSizeText(
                    //               "Obasanas Designs  Ventures",
                    //               style: TextStyle(
                    //                 fontFamily: "Work Sans",
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: inactiveTab,
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 1.h,
                    //           ),
                    //           SizedBox(
                    //             width: 70.w,
                    //             child: const AutoSizeText(
                    //               "RC 126384",
                    //               style: TextStyle(
                    //                 fontFamily: "Work Sans",
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: inactiveTab,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    const AutoSizeText(
                      "Customer Details",
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
                      height: 2.5.h,
                    ),
                    const AutoSizeText(
                      "Order Item(s)",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    // const RemoveItem(),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    // SizedBox(
                    //   width: 90.w,
                    //   child: InvoiceField(
                    //     controller: foodController,
                    //     hintText: 'Food items for December',
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //       width: 43.w,
                    //       child: InvoiceField(
                    //           hintText: "2", controller: qtyController),
                    //     ),
                    //     SizedBox(
                    //       width: 43.w,
                    //       child: InvoiceField(
                    //           hintText: "$currencySymbol 150,000.00",
                    //           controller: priceController),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    InvoiceItemSection(
                      itemController: _invoiceController.itemNameController,
                      qtyController: _invoiceController.quantityController,
                      priceController: _invoiceController.priceController,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_invoiceController.itemNameController.text != "" &&
                            _invoiceController.quantityController.text != "" &&
                            _invoiceController.priceController.text != "") {
                          temporarilyAddedItems.add({
                            "itemname":
                                _invoiceController.itemNameController.text,
                            "quantity":
                                _invoiceController.quantityController.text,
                            "price": _invoiceController.priceController.text,
                          });
                          _invoiceController.itemNameController.clear();
                          _invoiceController.priceController.clear();
                          _invoiceController.quantityController.clear();
                          setState(() {});
                          return;
                        }
                        Fluttertoast.showToast(
                          msg: "Fill the form properly!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: const OrderItemButton(),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 1.5.h),
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: const AutoSizeText(
                              "Description",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const AutoSizeText(
                            "Unit*Rate",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const AutoSizeText(
                            "Total (NGN)",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: temporarilyAddedItems
                          .map(
                            (invoiceItem) => InvoiceItemDetailsCard(
                              itemname: invoiceItem['itemname']!,
                              quantity: int.parse(invoiceItem['quantity']!),
                              price: invoiceItem['price']!,
                              total:
                                  '${int.parse(invoiceItem['quantity']!) * int.parse(invoiceItem['price']!)}',
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Tax",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 43.w,
                          child: InvoiceField(
                            hintText: "Enter Tax Rate",
                            controller: _invoiceController.taxRateController,
                            textWeight: FontWeight.w400,
                            hintcolor: true,
                            onChanged: (p0) {
                              List<double> detailTotals =
                                  temporarilyAddedItems.map((item) {
                                return double.parse(item['quantity']!) *
                                    double.parse(item['price']!);
                              }).toList();
                              double detailTotal =
                                  detailTotals.reduce((a, b) => a + b);
                              setState(() {
                                taxAmount = (double.parse(_invoiceController
                                            .taxRateController.text) /
                                        100) *
                                    detailTotal;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 43.w,
                          child: InvoiceField(
                            hintText: "# 0.00",
                            enabled: false,
                            controller:
                                TextEditingController(text: '$taxAmount'),
                            textWeight: FontWeight.w400,
                            hintcolor: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    const AutoSizeText(
                      "Discount",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 43.w,
                          child: InvoiceField(
                            hintText: "Discount Rate",
                            controller:
                                _invoiceController.discountRateController,
                            textWeight: FontWeight.w400,
                            hintcolor: true,
                            onChanged: (p0) {
                              setState(() {
                                List<double> detailTotals =
                                    temporarilyAddedItems.map((item) {
                                  return double.parse(item['quantity']!) *
                                      double.parse(item['price']!);
                                }).toList();
                                double detailTotal =
                                    detailTotals.reduce((a, b) => a + b);
                                dicountAmount = (double.parse(_invoiceController
                                            .discountRateController.text) /
                                        100) *
                                    detailTotal;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 43.w,
                          child: InvoiceField(
                            hintText: "# 0.00",
                            enabled: false,
                            controller:
                                TextEditingController(text: '$dicountAmount'),
                            textWeight: FontWeight.w400,
                            hintcolor: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    const AutoSizeText(
                      "Order Item",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: const BoxDecoration(
                        color: fagoSecondaryColorWithOpacity10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: const AutoSizeText(
                                  "Sub Total",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: inactiveTab,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                                child: AutoSizeText(
                                  "$currencySymbol 3,00",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: inactiveTab,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: const AutoSizeText(
                                  "Inclusive Tax (7.5%)",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: inactiveTab,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                                child: AutoSizeText(
                                  "$currencySymbol 2,0",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: inactiveTab,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: const AutoSizeText(
                                  "Grand Total",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                                child: AutoSizeText(
                                  "$currencySymbol detailTotal",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Container(
                              height: 1,
                              width: 80.w,
                              color: fagoBlackColorWithOpacity15,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (selectedCustomerId != "" &&
                                    temporarilyAddedItems.isNotEmpty) {
                                  await createInvoice(context);
                                  return;
                                }
                                Fluttertoast.showToast(
                                  msg: "Fill the form properly!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              child: AuthButtons(
                                text: "Create Invoice",
                                form: true,
                              ),
                            ),
                          ),
                        ],
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

  Future<void> getCustomers() async {
    final companyId = _companyController.company!.id!;
    final response = await _customerController.getCustomers(companyId);
    final resBody = response['data']['customers'];
    final returnedCustomers = resBody
        .map<Customer>((customer) => Customer.fromJson(customer))
        .toList();
    setState(() {
      _customerController.customers = returnedCustomers;
    });
  }

  Future<void> createInvoice(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final companyId = _companyController.company!.id!;
    // final orderItem = {
    //   "itemname": _invoiceController.itemNameController.text,
    //   "quantity": _invoiceController.quantityController.text,
    //   "price": _invoiceController.priceController.text,
    // };
    final response = await _invoiceController.createBusinessInvoice(
      invoiceItemDetails: [...temporarilyAddedItems],
      companyId: companyId,
      customerId: selectedCustomerId,
      discountRate: _invoiceController.discountRateController.text,
      taxRate: _invoiceController.taxRateController.text,
    );

    final jsonBody = jsonDecode(response.body);

    print(jsonBody);

    if (response.statusCode == 200) {
      progress.dismiss();
      if (!mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Invoice Created Successfully",
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
}

class InvoiceItemSection extends StatelessWidget {
  const InvoiceItemSection({
    super.key,
    required this.itemController,
    required this.qtyController,
    required this.priceController,
    this.remove,
  });

  final TextEditingController itemController;
  final TextEditingController qtyController;
  final TextEditingController priceController;
  final VoidCallback? remove;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(onTap: remove, child: const RemoveItem()),
        SizedBox(
          height: 1.5.h,
        ),
        SizedBox(
          width: 90.w,
          child: InvoiceField(
            controller: itemController,
            hintText: 'Description',
            textWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 43.w,
              child: InvoiceField(
                hintText: "Quantity",
                controller: qtyController,
                textWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 43.w,
              child: InvoiceField(
                hintText: "Price",
                controller: priceController,
                textWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }
}
