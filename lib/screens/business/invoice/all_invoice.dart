import 'package:dio/dio.dart' as dio;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/business_invoice_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/business/book_keeping/booking_keeping.dart';
import 'package:fagopay/screens/business/invoice/components/custom_invoice_card.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/invoice_controller.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../book_keeping/models/model.dart';
import '../home/models/sales.model.dart';
import '../widgets/no_record.dart';
import 'add_invoice.dart';
import 'invoice_details.dart';

class AllInvoice extends StatefulWidget {
  const AllInvoice({super.key});

  @override
  State<AllInvoice> createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  final _invoiceController = Get.find<InvoiceController>();
  final _companyController = Get.find<CompanyController>();
  List<InvoiceList> get unpaidInvoices {
    return businessInvoiceResponse!.data!.invoiceList!
        .where((unpaidInvoice) =>
    unpaidInvoice.status == 'pending' ||
        unpaidInvoice.status == 'unpaid')
        .toList();
  }

  List<InvoiceList> get otherInvoices {
    return businessInvoiceResponse!.data!.invoiceList!.where((unpaidInvoice) =>
    unpaidInvoice.status != 'unpaid' &&
        unpaidInvoice.status != 'pending' &&
        unpaidInvoice.status != 'Paid')
        .toList();
  }

  BusinessInvoiceResponse? businessInvoiceResponse;
  bool? isLoadingInvoice;
  bool? isLoadingInvoiceHasError;

  Future<dio.Response<dynamic>?> getInvoice({required String companyId})async{
    isLoadingInvoice = true;
    isLoadingInvoiceHasError = false;
    setState(() {});
    try{
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/$companyId", method: RequestMethod.get);
      businessInvoiceResponse = BusinessInvoiceResponse.fromJson(response?.data);
      isLoadingInvoice = false;
      isLoadingInvoiceHasError = false;
      setState(() {});
      return response;
    }on dio.DioError catch (err) {
      isLoadingInvoice = false;
      isLoadingInvoiceHasError = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      isLoadingInvoice = false;
      isLoadingInvoiceHasError = true;
      setState(() {});
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  bool allTab = true;
  bool unPaidTab = false;
  bool partPaidTab = false;
  bool recordFound = true;
  bool isLoading = true;
  String? selectedFilter = '';
  int currentIndex = 0;
  late final PageController _controller = PageController(viewportFraction: 0.5);

  @override
  void initState() {
    getInvoice(companyId: _companyController.company!.id!);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BookKeepingModel> bookKeepingContent = [
      BookKeepingModel(
        accountType: " Total Invoice",
        description: "Income",
        balance: "${businessInvoiceResponse?.data?.totalInvoice ?? ""}",
        imagePath: "assets/images/inflow.svg",
      ),
      // BookKeepingModel(
      //   accountType: " Total Received",
      //   description: "Expenses",
      //   balance: "${businessInvoiceResponse?.data?.totalReceive ?? ""}",
      //   imagePath: "assets/images/outflow.svg",
      // ),
      BookKeepingModel(
        accountType: "Total Outstanding",
        description: businessInvoiceResponse?.data == null ? "" "#0.0, retrieved" : 
        "${businessInvoiceResponse!.data!.invoiceList?.where((e) => e.status == "Paid").toList().map((e) => double.parse(e.total.toString())).toList().reduce((a, b) => a+b)} retrieved",
        balance: businessInvoiceResponse?.data == null ? "0.0" :
        "${businessInvoiceResponse!.data!.invoiceList?.where((e) => e.status == "Paid").toList().map((e) => double.parse(e.total.toString())).toList().reduce((a, b) => a+b)}",
        imagePath: "assets/images/total_credit.svg",
      ),
      // BookKeepingModel(
      //   accountType: "Sales Account",
      //   description: "Customer’s Debt",
      //   balance: businessInvoiceResponse?.data == null ? "0.0" : "${businessInvoiceResponse!.data!.invoiceList!.map((e) => num.parse(e.total!)).toList().sumBy((element) => element) -
      //       businessInvoiceResponse!.data!.invoiceList!.map((e) => num.parse(e.total!)).toList().sumBy((element) => element)}",
      //   imagePath: "assets/images/total_debit.svg",
      // ),
    ];
    return GetBuilder<InvoiceController>(
      init: InvoiceController(),
        builder: (controller){
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: ()async{
            getInvoice(companyId: _companyController.company!.id!);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Invoice",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // goToPage(context, const AddInvoice());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddInvoice()));
                        },
                        child: SizedBox(
                          width: 45.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 1.h,
                            ),
                            decoration: const BoxDecoration(
                              color: fagoSecondaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/fluent_receipt-20-filled.png",
                                  color: white,
                                ),
                                const AutoSizeText(
                                  "New Invoice",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 12.h,
                    child: PageView.builder(
                        controller: _controller,
                        padEnds: false,
                        itemCount: bookKeepingContent.length,
                        onPageChanged: (int index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, i) {
                          return SizedBox(
                            width: 43.w,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // goToPage(context, const AllSales());
                                  },
                                  // child: Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 2.w, vertical: 1.h),
                                  //   decoration: const BoxDecoration(
                                  //       color: white,
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(5)),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: blackWithOpacity,
                                  //           offset: Offset.zero,
                                  //           spreadRadius: 1,
                                  //           blurRadius: 3,
                                  //         ),
                                  //       ]),
                                  child: SizedBox(
                                    width: 43.w,
                                    child: Card(
                                      elevation: 1.5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                bookKeepingContent[i].imagePath),
                                            SizedBox(width: 1.w),
                                            // Container(
                                            //   height: 53,
                                            //   decoration: DottedDecoration(
                                            //       color: blackWithOpacity5,
                                            //       // dash: const [1, 1, 1],
                                            //       linePosition: LinePosition.right),
                                            // ),
                                            SvgPicture.asset(
                                                "assets/images/Line.svg"),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    bookKeepingContent[i].accountType,
                                                    style: const TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 12,
                                                      color: inactiveTab,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  AutoSizeText(
                                                    "$currencySymbol${bookKeepingContent[i].balance}",
                                                    style: TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 18,
                                                        color: (i == 1 ||
                                                            i ==
                                                                (bookKeepingContent
                                                                    .length -
                                                                    1))
                                                            ? fagoSecondaryColor
                                                            : inactiveTab,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  AutoSizeText(
                                                    bookKeepingContent[i]
                                                        .description,
                                                    style: TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 10,
                                                        color: (i == 2)
                                                            ? fagoGreenColor
                                                            : inactiveTabWithOpacity30,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1.5.w,
                                )
                              ],
                            ),
                          ); // ]
                        }),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      bookKeepingContent.length,
                          (index) => buildDot(index, context),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Container(
                    height: 0.5,
                    decoration: const BoxDecoration(
                      color: blackWithOpacity10,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            allTab = true;
                            partPaidTab = false;
                            unPaidTab = false;
                          });
                        },
                        child: Container(
                          width: 20.5.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: (allTab)
                                      ? fagoSecondaryColor
                                      : Colors.transparent),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: AutoSizeText(
                              "All",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                (allTab) ? fagoSecondaryColor : inactiveTab,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            allTab = false;
                            partPaidTab = false;
                            unPaidTab = true;
                          });
                        }),
                        child: Container(
                          width: 20.5.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: (unPaidTab)
                                      ? fagoSecondaryColor
                                      : Colors.transparent),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: AutoSizeText(
                              "Unpaid",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: (unPaidTab)
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
                            allTab = false;
                            partPaidTab = true;
                            unPaidTab = false;
                          });
                        }),
                        child: Container(
                          width: 20.5.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: (partPaidTab)
                                      ? fagoSecondaryColor
                                      : Colors.transparent),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: AutoSizeText(
                              "Part Paid",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: (partPaidTab)
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
                  // Record Found
                  recordFound && allTab ? Container(height: 45.h, padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: businessInvoiceResponse == null ||
                        businessInvoiceResponse!.data!.invoiceList!.isEmpty &&
                        isLoadingInvoice == true && isLoadingInvoiceHasError == false ?
                    const Center(
                      child: LoadingWidget(
                        size: 20,
                        color: fagoSecondaryColor,
                      ),
                    ) : businessInvoiceResponse != null ||
                        businessInvoiceResponse!.data!.invoiceList!.isNotEmpty && isLoadingInvoice == false && isLoadingInvoiceHasError == false ?
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: businessInvoiceResponse!.data!.invoiceList!.length,
                      itemBuilder: (context, index) => CustomInvoiceCard(
                        customerName: businessInvoiceResponse!.data!.invoiceList![index].customer?.fullname ?? "",
                        date: Jiffy.parse(businessInvoiceResponse!.data!.invoiceList![index].createdAt!.toString()).format(pattern: 'dd MMM yyyy'),
                        total: businessInvoiceResponse!.data!.invoiceList![index].total!,
                        status: businessInvoiceResponse!.data!.invoiceList![index].status!,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => InvoiceDetails(invoiceId: businessInvoiceResponse!.data!.invoiceList![index].id!,),
                            settings: RouteSettings(arguments: businessInvoiceResponse!.data!.invoiceList![index].id!,),
                          ),
                        ),
                      ),
                    ) :  const Center(
                      child: LoadingWidget(
                        size: 20,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ) : recordFound && unPaidTab
                      ? Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.w, vertical: 1.h),
                    decoration: const BoxDecoration(
                        color: Colors.transparent),
                    child: unpaidInvoices.isEmpty
                        ? const Center(
                      child: AutoSizeText('No Invoice yet'),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      itemCount: unpaidInvoices.length,
                      itemBuilder: (context, index) =>
                          CustomInvoiceCard(
                            customerName: unpaidInvoices[index]
                                .customer!.fullname ?? "",
                            date: Jiffy.parse(unpaidInvoices[index]
                                .createdAt!.toString())
                                .format(pattern: 'dd MMM yyyy'),
                            total: unpaidInvoices[index].total!,
                            status: unpaidInvoices[index].status!,
                            onPressed: () =>
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                     InvoiceDetails(invoiceId: businessInvoiceResponse!.data!.invoiceList![index].id!,),
                                    settings: RouteSettings(
                                      arguments: unpaidInvoices[index].id!,
                                    ),
                                  ),
                                ),
                          ),
                    ),
                  )
                      : Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.w, vertical: 1.h),
                    decoration: const BoxDecoration(
                        color: Colors.transparent),
                    child: otherInvoices.isEmpty
                        ? const Center(
                      child: AutoSizeText('No Invoice yet'),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      itemCount: otherInvoices.length,
                      itemBuilder: (context, index) =>
                          CustomInvoiceCard(
                            customerName: otherInvoices[index]
                                .customer!.fullname ?? "",
                            date: Jiffy.parse(otherInvoices[index]
                                .createdAt!.toString())
                                .format(pattern: 'dd MMM yyyy'),
                            total: otherInvoices[index].total!,
                            status: otherInvoices[index].status!,
                            onPressed: () =>
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                     InvoiceDetails(invoiceId: businessInvoiceResponse!.data!.invoiceList![index].id!),
                                    settings: RouteSettings(
                                      arguments: otherInvoices[index].id!,
                                    ),
                                  ),
                                ),
                          ),
                    ),
                  ),
                  // No record Found
                  if (!recordFound)
                    const NoRecordFound(
                      recordDescription: 'Create invoice now and share to your customers to get paid easily.',
                      recordRoute: AddInvoice(),
                      recordText: 'Invoice',
                    )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }



  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 18 : 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? fagoSecondaryColor
            : fagoSecondaryColorWithOpacity,
      ),
    );
  }

  // Future<void> getBusinessInvoices() async {
  //   final companyId = _companyController.company!.id!;
  //   log(companyId.toString());
  //   final response = await _invoiceController.getInvoices(companyId);
  //   final resBody = response['data']['Invoice_List'];
  //   final returnedInvoices =
  //       resBody.map<Invoice>((invoice) => Invoice.fromJson(invoice)).toList();
  //   setState(() {
  //   //  isLoading = false;
  //     _invoiceController.invoices = returnedInvoices;
  //   });
  // }
}
//_invoiceController.invoices.isEmpty
//                               ? const Center(
//                                   child: AutoSizeText('No Invoice yet'),
//                                 )
//                               : ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   shrinkWrap: true,
//                                   physics: const AlwaysScrollableScrollPhysics(),
//                                   itemCount: _invoiceController.invoices.length,
//                                   itemBuilder: (context, index) => CustomInvoiceCard(
//                                     customerName: _invoiceController.invoices[index].customer!['fullname'],
//                                     date: Jiffy.parse(_invoiceController.invoices[index].createdAt!).format(pattern: 'dd MMM yyyy'),
//                                     total: _invoiceController.invoices[index].total!,
//                                     status: _invoiceController.invoices[index].status!,
//                                     onPressed: () => Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) => const InvoiceDetails(),
//                                         settings: RouteSettings(arguments: _invoiceController.invoices[index].id!,),
//                                       ),
//                                     ),
//                                   ),
//                                 ),