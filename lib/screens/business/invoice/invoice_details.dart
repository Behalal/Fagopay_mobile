import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/invoice_controller.dart';
import 'package:fagopay/models/business_invoice_model.dart';
import 'package:fagopay/models/invoice_details_response.dart';
import 'package:fagopay/screens/authentication/widgets/email_phone_input.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../controllers/user_controller.dart';
import 'components/invoice_item_details_card.dart';
import 'package:jiffy/jiffy.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'dart:ui' as ui;

class InvoiceDetails extends StatefulWidget {
  final String invoiceId;
  const InvoiceDetails({super.key, required this.invoiceId});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();
  final logAmountController = TextEditingController();
  BusinessInvoiceResponse? businessInvoiceResponse;
  InvoiceList findInvoiceById(String id) {
    return businessInvoiceResponse!.data!.invoiceList!.firstWhere((invoice) => invoice.id == id);
  }

  bool? isLoadingInvoiceDetails;
  bool? isLoadingInvoiceDetailsHasError;
  InvoiceDetailsResponse? invoiceDetailsResponse;

  Future<dio.Response<dynamic>?> getInvoiceDetailsById({required String invoiceId})async{
    isLoadingInvoiceDetails = true;
    isLoadingInvoiceDetailsHasError = false;
    setState(() {});
    try{
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/single/$invoiceId", method: RequestMethod.get);
      invoiceDetailsResponse = InvoiceDetailsResponse.fromJson(response?.data);
      isLoadingInvoiceDetails = false;
      isLoadingInvoiceDetailsHasError = false;
      // customerDetailsTab = true;
      // transactionDetailsTab = false;
      setState(() {});
      return response;
    }on dio.DioError catch (err) {
      isLoadingInvoiceDetails = false;
      isLoadingInvoiceDetailsHasError = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      isLoadingInvoiceDetails = false;
      isLoadingInvoiceDetailsHasError = true;
      setState(() {});
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  var scr = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  takeScreenShot() async {
    RenderRepaintBoundary boundary = scr.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      // Timer(const Duration(seconds: 1), () => saveScreen());
      return null;
    }
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (!(await Permission.storage.status.isGranted)) {
      await Permission.storage.request();
    }
    final result = await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
    if (kDebugMode) {
      print('$byteData ********** Saved to gallery *********** $result');
    }
  }

  shareImage()async{
    await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }
    });
  }

  void logAmountDialog({required void Function()? onTap}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/3.1,), padding: const EdgeInsets.symmetric( vertical: 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 100, height: 2, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(10)),),
              const SizedBox(height: 15,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Log Payment", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: fagoSecondaryColor, fontSize: 22, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 40,),
                  Container(
                    width: double.maxFinite, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13), color: fagoSecondaryColorWithOpacity10,
                    child: EmailPhone(
                      keyboardType: TextInputType.phone,
                      prefixIcon: const SizedBox(),
                      hintText: "Enter amount to log",
                      controller: logAmountController,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: onTap,
                    child: Container(height: 50,
                        width: Get.width/1.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: fagoSecondaryColor, border: Border.all(color: fagoSecondaryColor)
                        ),
                        child: Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/stickynotewhite.png", height: 20, width: 20,),
                              const SizedBox(width: 10,),
                              const AutoSizeText(
                                "Log Payment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  void markAsPaidDialog({required void Function()? onTap}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/3.3,), padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 130, height: 2, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(10)),),
              const SizedBox(height: 15,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Mark as Paid", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: fagoSecondaryColor, fontSize: 22, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 29,),
                  const Divider(),
                  RichText(textAlign: TextAlign.center,
                    text: TextSpan(text: "Are you sure to mark this invoice \nas paid?",
                      style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color(0xff576275), fontSize: 15, fontWeight: FontWeight.w600),
                  ),),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: onTap,
                    child: Container(height: 50,
                        width: Get.width/1.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: fagoSecondaryColor, border: Border.all(color: fagoSecondaryColor)
                        ),
                        child: Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/stickynotewhite.png", height: 20, width: 20,),
                              const SizedBox(width: 10,),
                              const AutoSizeText(
                                "Mark as paid",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  void sendMailDialog({required void Function()? onTap,required void Function()? onTap1, required String email}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/2.5,), padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 130, height: 2, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(10)),),
              const SizedBox(height: 15,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Share Invoice", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: fagoSecondaryColor, fontSize: 22, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 15,),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(textAlign: TextAlign.start,
                            text: TextSpan(text: "Mail invoice to customer",
                              style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color(0xff576275), fontSize: 15, fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(text: "\n$email", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: stepsColor, fontSize: 14, fontWeight: FontWeight.w400),)
                              ]
                          ),),
                        ),
                        InkWell(
                          onTap: onTap,
                          child: Container(height: 50,
                              width: Get.width/3.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  color: Colors.white, border: Border.all(color: fagoSecondaryColor)
                              ),
                              child: Center(
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/stickynote.png", height: 20, width: 20,),
                                    const SizedBox(width: 10,),
                                    const AutoSizeText(
                                      "Mail Now",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w600,
                                          color: fagoSecondaryColor),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Text("Share invoice through other channels",
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: stepsColor, fontSize: 15, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 15,),
                  InkWell(
                    onTap: onTap1,
                    child: Container(height: 50,
                        width: Get.width/1.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: fagoSecondaryColor, border: Border.all(color: fagoSecondaryColor)
                        ),
                        child: Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/stickynotewhite.png", height: 20, width: 20,),
                              const SizedBox(width: 10,),
                              const AutoSizeText(
                                "Share invoice Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  @override
  void initState() {
    getInvoiceDetailsById(invoiceId: widget.invoiceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final invoiceId = ModalRoute.of(context)!.settings.arguments as String;
    // final invoice = findInvoiceById(invoiceId);
    final buttonTitle = [
      "Log Payment",
      "Mark Invoice as Paid",
    ];
    return GetBuilder<InvoiceController>(
      init: InvoiceController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body:invoiceDetailsResponse == null &&
              isLoadingInvoiceDetails == true &&
              isLoadingInvoiceDetailsHasError == false ?
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CupertinoActivityIndicator(color: fagoSecondaryColor,),
                const SizedBox(height: 15,),
                Text("Please wait", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
              ],
            ),
          ) : invoiceDetailsResponse != null && isLoadingInvoiceDetails == false && isLoadingInvoiceDetailsHasError == false ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Image(image: AssetImage("assets/images/Icon.png")),
                        iconSize: 20,
                      ),
                      const Spacer(),
                      const AutoSizeText('View Invoice',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                      const Spacer(),
                      Align(alignment: Alignment.topRight,
                        child: PopupMenuButton(
                          child: const Icon(Icons.more_vert_outlined, size: 25, color: Color(0XFF187226),),
                          itemBuilder: (context) {
                            return List.generate(buttonTitle.length, (index) {
                              return PopupMenuItem(
                                child: Text(buttonTitle[index], style: Theme.of(context).textTheme.bodyLarge?.copyWith(),),
                                onTap: (){
                                  if(index == 0){
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        logAmountDialog(onTap: () {
                                          Get.back();
                                          controller.logPayment(invoiceId: widget.invoiceId, amountPaid: logAmountController.text, context: context);
                                        });
                                      });
                                  }else if(index == 1){
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      markAsPaidDialog(onTap: () {
                                        Get.back();
                                        controller.markInvoiceAsPaid(invoiceId: widget.invoiceId, context: context);
                                      });
                                    });
                                  }
                                },
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(color: fagoSecondaryColor,),
                ),
                RepaintBoundary(
                  key: scr,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        color: Colors.white,
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
                                    invoiceDetailsResponse?.data?.invoice?.company?.companyName ?? "",
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
                                        invoiceDetailsResponse?.data?.invoice?.company?.emailAddress ?? '',
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
                                            invoiceDetailsResponse?.data?.invoice?.invoiceNo ?? "",
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
                                            Jiffy.parse(invoiceDetailsResponse?.data?.invoice?.createdAt?.toString() ?? DateTime.now().toString())
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
                                        "${invoiceDetailsResponse?.data?.invoice?.company?.address ?? ''}, ${invoiceDetailsResponse?.data?.invoice?.company?.city ?? ''},",
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
                                        invoiceDetailsResponse?.data?.invoice?.company?.state ?? '',
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
                                        invoiceDetailsResponse?.data?.invoice?.customer?.fullname ?? "",
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
                                        "${invoiceDetailsResponse?.data?.invoice?.customer?.phoneNumber ?? ''} | ${invoiceDetailsResponse?.data?.invoice?.customer?.email ?? ''}",
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
                                        "${invoiceDetailsResponse?.data?.invoice?.customer?.address ?? ''}, ${invoiceDetailsResponse?.data?.invoice?.customer?.city ?? ''},",
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
                                        "${invoiceDetailsResponse?.data?.invoice?.customer?.state ?? ''}, ${invoiceDetailsResponse?.data?.invoice?.customer?.country ?? ''}",
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
                              children: invoiceDetailsResponse!.data!.invoice!.invoiceDetail!
                                  .map(
                                    (invoiceItem) => InvoiceItemDetailsCard(
                                  itemname: invoiceItem.itemname!,
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
                                  invoiceDetailsResponse?.data?.invoice?.total ?? "",
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
                                  "Tax (${double.parse(invoiceDetailsResponse?.data?.invoice?.taxRate ?? "0.0").toStringAsFixed(1)}% VAT)",
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  invoiceDetailsResponse?.data?.invoice?.taxAmount ?? "",
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
                                  "Discount (${double.parse(invoiceDetailsResponse?.data?.invoice?.discountRate ?? "0.0").toStringAsFixed(1)}%)",
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  invoiceDetailsResponse?.data?.invoice?.discountAmount ?? "",
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
                                  "$currencySymbol${invoiceDetailsResponse?.data?.invoice?.total}",
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
                                    _userController.switchedAccountType == 2
                                        ? _companyController
                                        .company!.account!.accountName ??
                                        ''
                                        : _userController
                                        .userAccountDetails!.accountName ??
                                        '',
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
                                          _userController.switchedAccountType == 2
                                              ? _companyController.company!.account?.accountNumber ??
                                              ''
                                              : _userController.userAccountDetails!
                                              .accountNumber ??
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
                                    _userController.switchedAccountType == 2
                                        ? _companyController
                                        .company!.account!.bankName ??
                                        ''
                                        : _userController.userAccountDetails!.bankName ??
                                        '',
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
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            sendMailDialog(onTap: () {
                              Get.back();
                              shareImage();
                              }, email: invoiceDetailsResponse?.data?.invoice?.customer?.email ?? '',
                                onTap1: () {
                              Get.back();
                              shareImage();
                            });
                          });
                        },
                        child: Container(height: 50,
                            width: Get.width/2.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: fagoSecondaryColor, border: Border.all(color: fagoSecondaryColor)
                            ),
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/sms-tracking.svg", height: 20, width: 20,),
                                  const SizedBox(width: 10,),
                                  const AutoSizeText(
                                    "Mail Invoice",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Work Sans",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      const SizedBox(width: 40,),
                      InkWell(
                        onTap: (){
                          takeScreenShot();
                          Get.snackbar("Success", "Saved to gallery");
                        },
                        child: Container(height: 50,
                            width: Get.width/2.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: fagoPrimaryColor, border: Border.all(color: fagoPrimaryColor)
                            ),
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/document-download.png", height: 20, width: 20,),
                                  const SizedBox(width: 10,),
                                  const AutoSizeText(
                                    "Download",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Work Sans",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ): const SizedBox(),
        ),
      );
    });
  }
}
