// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/customers_controller.dart';
import 'package:fagopay/models/customer_details.dart';
import 'package:fagopay/screens/constants/custom_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;
import 'package:url_launcher/url_launcher.dart';
import '../../../service/network_services/dio_service_config/dio_client.dart';
import '../../../service/network_services/dio_service_config/dio_error.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../widgets/boxes.dart';

class CustomerDetailsPage extends StatefulWidget {
  final String customerId;
  const CustomerDetailsPage({
    Key? key, required this.customerId,
  }) : super(key: key);

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {

  bool? isLoadingCustomerDetails;
  bool? isLoadingCustomerDetailsHasError;
  late bool customerDetailsTab;
  late bool transactionDetailsTab;
  CustomerDetailsResponseModel? customerDetails;

  Future<dio.Response<dynamic>?> getCustomerDetailsById({required String customerId})async{
    isLoadingCustomerDetails = true;
    isLoadingCustomerDetailsHasError = false;
    setState(() {});
    try{
      final response = await NetworkProvider().call(path: "/v1/customer/$customerId", method: RequestMethod.get);
      customerDetails = CustomerDetailsResponseModel.fromJson(response?.data);
      isLoadingCustomerDetails = false;
      isLoadingCustomerDetailsHasError = false;
      customerDetailsTab = true;
      transactionDetailsTab = false;
      setState(() {});
      return response;
    }on dio.DioError catch (err) {
      isLoadingCustomerDetails = false;
      isLoadingCustomerDetailsHasError = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      isLoadingCustomerDetails = false;
      isLoadingCustomerDetailsHasError = true;
      setState(() {});
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  @override
  void initState() {
    getCustomerDetailsById(customerId: widget.customerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final customerId = ModalRoute.of(context)!.settings.arguments as String;
    // final customer = _customerController.findCustomerById(customerId);
    return  Scaffold(
        body: customerDetails == null &&
            isLoadingCustomerDetails == true &&
            isLoadingCustomerDetailsHasError == false ?
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CupertinoActivityIndicator(color: fagoSecondaryColor,),
              const SizedBox(height: 15,),
              Text("Please wait", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
            ],
          ),
        ) : customerDetails != null && isLoadingCustomerDetails == false && isLoadingCustomerDetailsHasError == false ?
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressStyle(
                  stage: 0,
                  pageName: customerDetails?.data?.customer?.fullname ?? "",
                  icon: "assets/images/profile-delete.png",
                  onPressedIconAction: () {
                    print('goooall');
                  },
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
                        child:  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customerDetails!.data!.customer!.customerTransactions!.isEmpty ?
                              const AutoSizeText("0.00",
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 28,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w700),
                              ) :
                              AutoSizeText(customerDetails?.data?.customer?.customerTransactions?.map((e) => e.total).toList().reduce((a, b) => (a!+b!))?.toString() ?? "0.00",
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 20,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 1.5.h,),
                              const AutoSizeText(
                                "Transaction Volume",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w500),
                              ),
                            ])),
                    Container(width: 43.w, height: 42.w,
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
                                  "No. of Transaction",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12, color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ]))
                  ],
                ),
                // customerDetails!.data!.customer!.customerTransactions!.isEmpty ?
                // CustomerBox(
                //   firstBoxDescription: "Transaction Volume",
                //   firstBoxMainValue: "0.00",
                //   secondBoxMainValue: "14",
                //   secondBoxDescription: "No. of Transaction",
                // ) :
                // CustomerBox(
                //   firstBoxDescription: "Transaction Volume",
                //   firstBoxMainValue: customerDetails?.data?.customer?.customerTransactions?.map((e) => e.total).toList().reduce((a, b) => (a!+b!))?.substring(0,7) ?? "0.00",
                //   secondBoxMainValue: "14",
                //   secondBoxDescription: "No. of Transaction",
                // ),
                SizedBox(height: 3.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
                  decoration:
                  const BoxDecoration(color: fagoSecondaryColorWithOpacity10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          const AutoSizeText("Total Debt", textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: "Work Sans", fontSize: 14, color: inactiveTab, fontWeight: FontWeight.w500),),
                          customerDetails!.data!.customer!.customerTransactions!.isEmpty ?
                          const AutoSizeText("0.00",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 30,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700),
                          ) :

                          AutoSizeText(customerDetails?.data?.customer?.customerTransactions?.map((e) => e.amountPaid).toList().reduce((a, b) => (a!+b!))?.toString() ?? "0.00",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 30,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: ()=>launch("tel://${customerDetails?.data?.customer?.phoneNumber}"),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w, vertical: 1.h),
                          decoration: const BoxDecoration(
                              color: fagoSecondaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/biz_call.png",
                                color: white,
                              ),
                              AutoSizeText(
                                customerDetails?.data?.customer?.phoneNumber ?? "",
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
                    ],
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
                                    width: 0.5,
                                    color: (customerDetailsTab)
                                        ? fagoSecondaryColor
                                        : Colors.transparent))),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: const AutoSizeText(
                            "Customer Details",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
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
                                    width: 0.5,
                                    color: (transactionDetailsTab)
                                        ? fagoSecondaryColor
                                        : Colors.transparent))),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: const AutoSizeText(
                            "Transactions",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 16,
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
                if (customerDetailsTab)
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
                            AutoSizeText(customerDetails?.data?.customer?.email ?? "",
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
                                  width: 0.2,
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
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 70.w,
                              child: AutoSizeText(customerDetails?.data?.customer?.address ?? "",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (transactionDetailsTab)
                  SizedBox(
                    width: 90.w,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 0.2,
                                        color: black,
                                      ))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const AutoSizeText(
                                    "Transactions",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 20,
                                        color: inactiveTab,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    child: const AutoSizeText(
                                      "View all",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          color: fagoSecondaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 2.h,
                          ),
                          customerDetails!.data!.customer!.customerTransactions!.isEmpty || customerDetails!.data!.customer!.customerTransactions == [] ?
                          Align(alignment: Alignment.center,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                Image.asset("assets/images/empty-folder.png", height: 60, width: 60,),
                                const SizedBox(height: 15,),
                                Text("No transaction record yet", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
                              ],
                            ),
                          ) : Column(
                            children: [
                              ...List.generate(customerDetails!.data!.customer!.customerTransactions!.length, (index){
                                final data = customerDetails!.data!.customer!.customerTransactions?[index];
                                return  SizedBox(
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
                                              SizedBox(width: 8.w),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    data?.reference ?? "",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 14,
                                                        color: inactiveTab,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Text(CustomDate.formatTransactionDate(data?.createdAt.toString() ?? DateTime.now().toString()),
                                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff576275), fontSize: 12),)
                                                ],
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
                                              "NGN ${data?.amountPaid ?? ""}",
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  color: fagoSecondaryColor,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w, vertical: 1.h),
                                              decoration: const BoxDecoration(
                                                  color: fagoGreenColorWithOpacity10,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10))),
                                              child: AutoSizeText(
                                                data?.status ?? "",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 8,
                                                    color: fagoGreenColor,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              }),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ]),
                  )
              ],
            ),
          ),
        ) : const SizedBox()
    ) ;
  }

}
