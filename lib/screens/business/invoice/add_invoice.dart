import 'package:auto_size_text/auto_size_text.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/head_style_extra_pages.dart';
import '../widgets/customer_details.dart';
import '../widgets/select_customer_modal.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  TextEditingController foodController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();
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
                            width: 0.5, color: fagoBlackColorWithOpacity15))),
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
                              const AutoSizeText(
                                "#10/11/2022",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: inactiveTab,
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
              SizedBox(
                height: 1.5.h,
              ),
              const AutoSizeText(
                "Business Detail",
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
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                decoration: const BoxDecoration(
                  color: fagoSecondaryColorWithOpacity10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 3.w,
                      backgroundColor: fagoSecondaryColorWithOpacity10,
                      child: Image.asset(
                        "assets/images/gallery.png",
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: const AutoSizeText(
                            "Obasanas Designs  Ventures",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: inactiveTab,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          width: 70.w,
                          child: const AutoSizeText(
                            "RC 126384",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: inactiveTab,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                height: 1.5.h,
              ),
              InkWell(
                  onTap: () {
                    showSelectCustomerModal(context);
                  },
                  child: const BusinessCustomerDetails()),
              SizedBox(
                height: 1.5.h,
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
              const RemoveItem(),
              SizedBox(
                height: 1.5.h,
              ),
              SizedBox(
                width: 90.w,
                child: InvoiceField(
                  controller: foodController,
                  hintText: 'Food items for December',
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
                    child:
                        InvoiceField(hintText: "2", controller: qtyController),
                  ),
                  SizedBox(
                    width: 43.w,
                    child: InvoiceField(
                        hintText: "$currencySymbol 150,000.00",
                        controller: priceController),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              const RemoveItem(),
              SizedBox(
                height: 1.5.h,
              ),
              SizedBox(
                width: 90.w,
                child: InvoiceField(
                  controller: foodController,
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 30.w),
                decoration: const BoxDecoration(
                  color: fagoSecondaryColorWithOpacity10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/addIcon.png",
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    const AutoSizeText(
                      "Order Item",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
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
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 43.w,
                    child: InvoiceField(
                      hintText: "Enter Tax Rate",
                      controller: qtyController,
                      textWeight: FontWeight.w400,
                      hintcolor: true,
                    ),
                  ),
                  SizedBox(
                    width: 43.w,
                    child: InvoiceField(
                      hintText: "# 0.00",
                      controller: priceController,
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
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 43.w,
                    child: InvoiceField(
                      hintText: "Discount Rate",
                      controller: qtyController,
                      textWeight: FontWeight.w400,
                      hintcolor: true,
                    ),
                  ),
                  SizedBox(
                    width: 43.w,
                    child: InvoiceField(
                      hintText: "# 0.00",
                      controller: priceController,
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
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                            "$currencySymbol 3,000",
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
                            "$currencySymbol 2,000",
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
                            "$currencySymbol 302,000",
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
                      child: AuthButtons(
                        text: "Create Invoice",
                        form: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showSelectCustomerModal(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // shape: const ShapeBorder().add(),
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return SelectCustomer(
          controller: searchCustomerController,
        );
      },
    );
  }
}

class InvoiceField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FontWeight textWeight;
  final bool hintcolor;
  final bool bgColor;
  final bool txtColor;

  const InvoiceField({
    super.key,
    required this.hintText,
    required this.controller,
    this.textWeight = FontWeight.w600,
    this.hintcolor = false,
    this.bgColor = false,
    this.txtColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontFamily: "Work Sans",
        fontWeight: textWeight,
        fontSize: 14,
        color: (txtColor) ? fagoSearchColor : inactiveTab,
      ),
      decoration: InputDecoration(
        filled: bgColor,
        fillColor: (bgColor) ? white : null,
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
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "Work Sans",
          fontWeight: textWeight,
          fontSize: 14,
          color: (txtColor)
              ? fagoSearchColor
              : (hintcolor)
                  ? signInPlaceholder
                  : inactiveTab,
        ),
      ),
    );
  }
}

class RemoveItem extends StatelessWidget {
  const RemoveItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70.w,
          height: 0.5,
          color: fagoBlackColorWithOpacity10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
          decoration: const BoxDecoration(
              color: fagoSecondaryColorWithOpacity10,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/archive.png",
                ),
                SizedBox(
                  width: 0.3.w,
                ),
                const AutoSizeText(
                  "Remove",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: fagoSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
