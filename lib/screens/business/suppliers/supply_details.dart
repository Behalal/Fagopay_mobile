import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/supplier_details_model.dart';
import 'package:fagopay/screens/business/suppliers/add_supplier.dart';
import 'package:fagopay/screens/constants/custom_date.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../functions.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../widgets/boxes.dart';

class SupplyDetails extends StatefulWidget {
  final String supplierId;
  const SupplyDetails({super.key, required this.supplierId});

  @override
  State<SupplyDetails> createState() => _SupplyDetailsState();
}

class _SupplyDetailsState extends State<SupplyDetails> {
  late bool customerDetailsTab;
  late bool transactionDetailsTab;

  bool? isLoadingSupplierDetails;
  bool? isLoadingSupplierDetailsHasError;
  SupplierDetailModel? supplierDetails;

  Future<dio.Response<dynamic>?> getCustomerDetailsById({required String customerId})async{
    isLoadingSupplierDetails = true;
    isLoadingSupplierDetailsHasError = false;
    setState(() {});
    try{
      final response = await NetworkProvider().call(path: "/v1/supplier/$customerId", method: RequestMethod.get);
      supplierDetails = SupplierDetailModel.fromJson(response?.data);
      isLoadingSupplierDetails = false;
      isLoadingSupplierDetailsHasError = false;
      customerDetailsTab = true;
      transactionDetailsTab = false;
      setState(() {});
      return response;
    }on dio.DioError catch (err) {
      isLoadingSupplierDetails = false;
      isLoadingSupplierDetailsHasError = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      isLoadingSupplierDetails = false;
      isLoadingSupplierDetailsHasError = true;
      setState(() {});
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  @override
  void initState() {
    customerDetailsTab = true;
    transactionDetailsTab = false;
    getCustomerDetailsById(customerId: widget.supplierId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final supplierId = ModalRoute.of(context)!.settings.arguments as String;
    // final supplier = _supplierController.findSupplierById(supplierId);
    return Scaffold(
      body: supplierDetails == null &&
          isLoadingSupplierDetails == true &&
          isLoadingSupplierDetailsHasError == false ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(color: fagoSecondaryColor,),
            const SizedBox(height: 15,),
            Text("Please wait", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
          ],
        ),
      ) : supplierDetails != null && isLoadingSupplierDetails == false && isLoadingSupplierDetailsHasError == false ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressStyle(
                stage: 0,
                pageName: capitalize(supplierDetails?.data?.supplierDetail?.name ?? ""),
                // backRoute: AllSupplies(),
                icon: "assets/images/profile-delete.png",
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 43.w, height: 42.w,
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                      decoration: const BoxDecoration(color: fagoSecondaryColorWithOpacity10,),
                      child:  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            supplierDetails!.data!.supplierDetail!.transactions!.map((e) => e.amount).toList().reduce((a, b) => (a!+b!))!.length <= 3 ?
                            AutoSizeText(supplierDetails?.data?.supplierDetail?.transactions?.map((e) => e.amount).toList().reduce((a, b) => (a!+b!))?.toString() ?? "0.00",
                              style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 28,
                                  color: fagoSecondaryColor,
                                  fontWeight: FontWeight.w700),
                            ) :  AutoSizeText(supplierDetails?.data?.supplierDetail?.transactions?.map((e) => e.amount).toList().reduce((a, b) => (a!+b!))?.substring(0,6) ?? "0.00",
                              style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 28,
                                  color: fagoSecondaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 1.5.h,),
                            const AutoSizeText(
                              "Total Paid Out",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  color: inactiveTab,
                                  fontWeight: FontWeight.w500),
                            ),
                          ])),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> const AddSupplies());
                    },
                    child: Container(width: 43.w, height: 42.w,
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                        decoration: const BoxDecoration(color: fagoSecondaryColorWithOpacity10,),
                        child:  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 4.h,
                                child: const CircleAvatar(
                                  backgroundColor: white,
                                  child: Icon(Icons.add, color: fagoSecondaryColor,),
                                ),
                              ),
                              SizedBox(height: 1.5.h,),
                              const FittedBox(
                                child: AutoSizeText(
                                  "Add New Transaction",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12, color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ])),
                  )
                ],
              ),
              // CustomerBox(
              //   onlyText: true,
              //   firstBoxDescription: "Amount Paid",
              //   firstBoxMainValue: "50,000",
              //   secondBoxMainValue: "14",
              //   secondBoxDescription: "No. of Transaction",
              // ),
              SizedBox(
                height: 3.h,
              ),
              const AutoSizeText(
                "Contact",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: inactiveTab,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: ()=>launch("tel://${supplierDetails?.data?.supplierDetail?.phone}"),
                child: Container(
                  width: 30.w,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: const BoxDecoration(
                      color: fagoGreenColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/biz_call.svg",
                        color: white,
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      AutoSizeText(
                        supplierDetails?.data?.supplierDetail?.phone ?? "",
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 10,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        customerDetailsTab = true;
                        transactionDetailsTab = false;
                      });
                    },
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: (customerDetailsTab)
                                  ? fagoGreenColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Customer Details",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        customerDetailsTab = false;
                        transactionDetailsTab = true;
                      });
                    }),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: (transactionDetailsTab)
                                  ? fagoGreenColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Transactions",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
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
              if (customerDetailsTab) ...[
                Column(
                  children: [
                    Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          const AutoSizeText(
                            "Bank Details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                            color: black,
                            width: 0.2,
                          )),
                          color: fagoSecondaryColorWithOpacity10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "Account Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                const AutoSizeText(
                                  "Account Number",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                const AutoSizeText(
                                  "Bank",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child: AutoSizeText(
                                    capitalize(supplierDetails?.data?.supplierDetail?.accountName ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                AutoSizeText(
                                  supplierDetails?.data?.supplierDetail?.accountNumber ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: fagoSecondaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                const AutoSizeText(
                                  "Guaranty Trust Bank",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: fagoSecondaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
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
                Column(
                  children: [
                    Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          const AutoSizeText(
                            "Email Address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          AutoSizeText(
                            supplierDetails?.data?.supplierDetail?.email ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                            color: black,
                            width: 0.1,
                          )),
                          color: fagoSecondaryColorWithOpacity10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          const AutoSizeText(
                            "Address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 70.w,
                            child: AutoSizeText(
                              supplierDetails?.data?.supplierDetail?.address ?? "",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              if (transactionDetailsTab)
                supplierDetails!.data!.supplierDetail!.transactions!.isEmpty || supplierDetails!.data!.supplierDetail!.transactions == [] ?
                Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/empty-folder.png", height: 60, width: 60,),
                    const SizedBox(height: 15,),
                    Text("No transaction record yet", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
                  ],
                ) : Column(
                  children: [
                    ...List.generate(supplierDetails!.data!.supplierDetail!.transactions!.length, (index){
                      final data = supplierDetails!.data!.supplierDetail!.transactions?[index];
                      return  Column(
                        children: [
                          SizedBox(
                              width: 90.w,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/Group 88.png',
                                          width: 8.w,
                                          height: 5.h,
                                        ),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                data?.note ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 15,
                                                    color: inactiveTab,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(CustomDate.formatTransactionDate(data?.expenseDate?.toString() ?? DateTime.now().toString()),
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 12),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "NGN ${data?.amount ?? ""}",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            color: fagoSecondaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          const Divider()
                        ],
                      );
                    }),
                  ],
                ),
            ],
          ),
        ),
      ) : const SizedBox(),
    );
  }
}
