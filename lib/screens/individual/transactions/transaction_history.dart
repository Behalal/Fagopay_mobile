// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/models/transaction.dart/transaction_history_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({
    super.key,
  });

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistoryPage> {
  final _transactionController = Get.find<TransactionController>();
  int? transactionType;
  @override
  void initState() {
    _transactionController.getTransactionHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //_transactionController.getTransactionHistory();
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const ProgressStyle(
                  //   stage: 0,
                  //   pageName: "Transactions",
                  //   // backRoute: MakeRequest(),
                  SizedBox(height: 6.h),
                  const AutoSizeText(
                    'Transactions',
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    ),
                  ),
                  const Divider(
                      thickness: 2, color: fagoPrimaryColorWithOpacity),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: SizedBox(
                      // height: 8.h,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.h, horizontal: 2.5.w),
                          child: Obx(() {
                            return _transactionController.transactionHistoryStatus == TransactionHistoryStatus.loading
                                ? const LoadingWidget(
                                    size: 50,
                                    color: fagoSecondaryColor,
                                  ) : _transactionController.transactionHistoryList.isNotEmpty
                                    ? ListView.separated(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: false,
                                        itemCount: _transactionController
                                            .transactionHistoryList.length,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                        itemBuilder: (context, index) {
                                          var item = _transactionController
                                              .transactionHistoryList[index];
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                transactionType = index;
                                              });
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor: white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top: Radius.circular(20),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder: (context) =>
                                                      TransactionDetails(
                                                    item: item,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                // height: 10.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      fagoSecondaryColorWithOpacity10,
                                                ),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(item
                                                                        .transactionType !=
                                                                    TransactionType
                                                                        .CREDIT
                                                                ? 'assets/icons/transfer_icon.svg'
                                                                : 'assets/icons/recived_from_icon.svg'),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 2.h,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: Column(
                                                                  // mainAxisAlignment:
                                                                  //     MainAxisAlignment
                                                                  //         .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      item.transactionType ==
                                                                              TransactionType.DEBIT
                                                                          ? 'Transfer to ${item.toFrom}'
                                                                          : 'Transfer from $currencySymbol${item.toFrom}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            "Work Sans",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color:
                                                                            stepsColor,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          1.h,
                                                                    ),
                                                                    AutoSizeText(
                                                                      " ${item.createdAt.year.toString()}-${item.createdAt.month.toString().padLeft(2, '0')}-${item.createdAt.day.toString().padLeft(2, '0')} ${item.createdAt.hour.toString().padLeft(2, '0')}:${item.createdAt.minute.toString().padLeft(2, '0')}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            "Work Sans",
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            stepsColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            AutoSizeText(
                                                              item.transactionType ==
                                                                      TransactionType
                                                                          .DEBIT
                                                                  ? '$currencySymbol${item.outflow}'
                                                                      .toString()
                                                                  : '$currencySymbol${item.inflow}'
                                                                      .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Work Sans",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color:
                                                                    fagoSecondaryColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Container(
                                                              height: 17,
                                                              width: 60,
                                                              decoration: BoxDecoration(
                                                                  color: white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25)),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                item.transactionStatus ==
                                                                        TransactionStatus
                                                                            .SUCCESS
                                                                    ? 'Success'
                                                                    : 'pending',
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      "Work Sans",
                                                                  fontSize: 5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      fagoGreenColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : const Center(
                                        child: AutoSizeText(
                                          'No history found',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: stepsColor,
                                          ),
                                        ),
                                      );
                          })),
                    ),
                  )
                ])));
  }
}

class TransactionDetails extends StatefulWidget {
  final TransactionHistoryModel item;
  const TransactionDetails({super.key, required this.item});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  // ignore: unused_field
  int _counter = 0;
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  final _transactionController = Get.find<TransactionController>();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: SizedBox(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 2.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 2.h,
              ),
              SvgPicture.asset('assets/icons/Frame 628228.svg'),
              SizedBox(
                height: 3.h,
              ),
              const AutoSizeText(
                'Transaction Details',
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: Get.width,
                  decoration:
                      const BoxDecoration(color: fagoSecondaryColorWithOpacity10),
                  child: Column(
                    children: [
                      AutoSizeText(
                        'yooo',
                   //     widget.item.transactionType! == TransactionType.DEBIT ? 'Transfer to ${widget.item.toFrom}' : 'Transfer from ${widget.item.toFrom}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: stepsColor,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText('Transaction Type',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: stepsColor,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              AutoSizeText(
                                'yo 2',
                               // widget.item.transactionType! == TransactionType.DEBIT ? 'Debit' : 'Credit',
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText('Amount',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: stepsColor,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              AutoSizeText(
                                widget.item.transactionType == TransactionType.DEBIT
                                    ? widget.item.outflow.toString()
                                    : widget.item.inflow.toString(),
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText('Transaction Date',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: stepsColor,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              AutoSizeText(
                                "${widget.item.createdAt.year.toString()}-${widget.item.createdAt.month.toString().padLeft(2, '0')}-${widget.item.createdAt.day.toString().padLeft(2, '0')} ${widget.item.createdAt.hour.toString().padLeft(2, '0')}:${widget.item.createdAt.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const AutoSizeText('Amount',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: stepsColor,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Container(
                                height: 17,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(25)),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  widget.item.transactionStatus ==
                                          TransactionStatus.SUCCESS
                                      ? 'Success'
                                      : 'pending',
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 5,
                                    fontWeight: FontWeight.w400,
                                    color: fagoGreenColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                            //  mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText('Naration',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: stepsColor,
                                    )),
                                SizedBox(height: 0.5.h),
                                Text(
                                 widget.item.description.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: stepsColor,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const AutoSizeText('Reference',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: stepsColor,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              AutoSizeText(
                                widget.item.reference.toString(),
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              btn(color: buttonColor,text: 'Share Payment Link',img: 'assets/icons/share.png',onTap: (){}),
              const SizedBox(height: 10),
              btn(color: fagoPrimaryColor,text: 'Download Receipt',img: 'assets/icons/download.png',onTap: (){
                screenshotController.capture().then((image) {
                  //Capture Done
                  print('object');
                  setState(() {
                    _imageFile = image;
                  });
                  print(_imageFile);
                }).catchError((onError) {
                  print(onError);
                });
              }),
              //Image.memory(_imageFile!)
            ],
          ),
        ),
      ),
    );
  }
  // shareImage()async{
  //   await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((image) async {
  //     if (image != null) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final imagePath = await File('${directory.path}/image.png').create();
  //       await imagePath.writeAsBytes(image);
  //       /// Share Plugin
  //       await Share.shareFiles([imagePath.path]);
  //     }
  //   });
  // }
  ///yuyu

  // _saveLocalImage() async {
  //   RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData =
  //   await (image.toByteData(format: ui.ImageByteFormat.png));
  //   if (byteData != null) {
  //     final result =
  //     await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
  //     print(result);
  //   }
  // }
  Widget btn({required String text, required String img,required Color color,required VoidCallback onTap}){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
        decoration:   BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        width: 30.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle(),
            ),
            SizedBox(width: 1.5.w,),
            Image.asset(img,height: 20,)
          ],
        ),
      ),
    );
  }
  TextStyle textStyle(){
    return const TextStyle(
        fontSize: 16,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w600,
        color: white
    );
  }
}
