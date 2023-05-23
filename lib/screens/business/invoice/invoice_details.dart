import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/business/invoice/components/invoice_item_details_card.dart';
import 'package:jiffy/jiffy.dart';
import '../../../controllers/invoice_controller.dart';
import 'package:get/get.dart';
import '../../authentication/widgets/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({super.key});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  final _invoiceController = Get.find<InvoiceController>();
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final invoiceId = ModalRoute.of(context)!.settings.arguments as String;
    final invoice = _invoiceController.findInvoiceById(invoiceId);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 1.h,
                left: 4.w,
                right: 4.w,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: const ProgressStyle(
                stage: 0,
                pageName: "View Invoice",
                shadow: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 45.w,
                        child: AutoSizeText(
                          invoice.company!['company_name'],
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // const AutoSizeText(
                            //   "+23490173458",
                            //   style: TextStyle(
                            //     fontFamily: "Work Sans",
                            //     fontSize: 10,
                            //     color: inactiveTab,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 0.5.h,
                            // ),
                            AutoSizeText(
                              invoice.company!['email_address'] ?? '',
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
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
                        width: 45.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  "Invoice No.",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  invoice.invoiceNo!,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  "Issued Date:",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  Jiffy.parse(invoice.createdAt!)
                                      .format(pattern: 'dd MMM, yyyy'),
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Due Date:",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              "${invoice.company!['address'] ?? ''}, ${invoice.company!['city'] ?? ''},",
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            AutoSizeText(
                              invoice.company!['state'] ?? '',
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
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
                              "Invoice to:",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            AutoSizeText(
                              invoice.customer!['fullname'],
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            AutoSizeText(
                              "${invoice.customer!['phone_number'] ?? ''} | ${invoice.customer!['email'] ?? ''}",
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              "${invoice.customer!['address'] ?? ''}, ${invoice.customer!['city'] ?? ''},",
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            AutoSizeText(
                              "${invoice.customer!['state'] ?? ''}, ${invoice.customer!['country'] ?? ''}",
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                color: inactiveTab,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
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
                    children: invoice.invoiceDetails!
                        .map(
                          (invoiceItem) => InvoiceItemDetailsCard(
                            itemname: invoiceItem.itemName!,
                            quantity: invoiceItem.quantity!,
                            price: invoiceItem.price!,
                            total: invoiceItem.total!,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Total",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          color: inactiveTab,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AutoSizeText(
                        invoice.total!,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Tax (${double.parse(invoice.taxRate!).toStringAsFixed(1)}% VAT)",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      AutoSizeText(
                        invoice.taxAmount!,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Discount (${double.parse(invoice.discountRate!).toStringAsFixed(1)}%)",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      AutoSizeText(
                        invoice.discountAmount!,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: inactiveTab,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Grand Total",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          color: fagoSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AutoSizeText(
                        "$currencySymbol${invoice.total}",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          color: fagoSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: fagoBlackColorWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
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
                          text: 'Note: ',
                          style: TextStyle(
                            color: fagoSecondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Payment should be made to',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Account Name:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: AutoSizeText(
                          _userController.userAccountDetails!.accountName ?? '',
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: inactiveTab,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Account no:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20.w,
                              child: AutoSizeText(
                                _userController
                                        .userAccountDetails!.accountNumber ??
                                    '',
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  color: inactiveTab,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              "assets/images/copy-svgrepo-com.png",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: const AutoSizeText(
                          "Bank:",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: inactiveTab,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: AutoSizeText(
                          _userController.userAccountDetails!.bankName ?? '',
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            color: inactiveTab,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 1,
              decoration: const BoxDecoration(
                color: fagoBlackColorWithOpacity10,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.5.h,
                horizontal: 6.w,
              ),
              decoration: const BoxDecoration(
                color: fagoSecondaryColorWithOpacity10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: AuthButtons(
                      text: "Mail Invoice",
                      form: false,
                      suffixImage: "assets/images/sms-tracking.png",
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: AuthButtons(
                      text: "Download",
                      form: false,
                      color: fagoPrimaryColor,
                      suffixImage: "assets/images/document-download.png",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
