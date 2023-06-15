// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:date_format/date_format.dart';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/models/transaction.dart/transaction_history_model.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../models/transaction.dart/tx_filter.dart';
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
  bool isFilter = false;
  bool isFilterLoading = false;
  TxFilterModel? _txFilterModel;

  @override
  void initState() {
    _transactionController.getTransactionHistory(type: 1);
    TransactionController().txFilterApi().then((value) {
      if(value.data.transactionFilter.isNotEmpty){
        setState(() {
          _txFilterModel =value;
          isFilterLoading = true;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
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
                    const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
                    // ),
                    SizedBox(
                      height: 2.h
                    ),
                    !isFilterLoading?Container(): GestureDetector(
                      onTap:(){
                        showFilter(context,isFilter);
                      } ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            width: 23.w,
                            margin: EdgeInsets.only(right: 1.5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: transactionKeys
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Filter by',style: Constant().textStyle(size: 14, weight: FontWeight.w500),),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                          Obx(() {
                            return   _transactionController.txFilterData == TxFlters.unActive? Container():GestureDetector(
                                onTap: (){
                                  _transactionController.getTransactionHistory(type: 1);
                                  _transactionController.txFilter(TxFlters.unActive);
                                },
                                child: const Icon(Icons.cancel_outlined));
                          })

                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 2.5.w),
                        child: Obx(() {
                          return _transactionController.transactionHistoryStatus == TransactionHistoryStatus.loading ? const LoadingWidget(size: 50, color: fagoSecondaryColor,) : _transactionController.transactionHistoryList.isNotEmpty
                                  ? ListView.separated(
                                      padding: EdgeInsets.zero,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _transactionController.transactionHistoryList.length,
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                                                ),
                                                context: context,
                                                builder: (context) => TransactionDetails(
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
                        }))
                  ],
              ),
          ),
        ),
    );
  }
  showFilter(BuildContext context,bool isFilter){
    String filter = _txFilterModel!.data.transactionFilter[0].name;
    String startDateString = '';
    int index = 1;
    String endDateDateString = '';
    date({required VoidCallback onTap,required String text,required String text2}){
      return  Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text2,style: Constant().textStyle(size: 15, weight: FontWeight.w500,color: black)),
            SizedBox(height: 0.5.h,),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.4.h,horizontal: 1.9.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: fagoSecondaryColorWithOpacity
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text),
                    SizedBox(width: 1.w,),
                    const Icon(Icons.calendar_month,size: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    DateTime startDate = DateTime.now();
    DateTime ?endDate;
    return  showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
        context: context,
        builder: (context) {
          return  StatefulBuilder(
              builder: (BuildContext context, setState) {
                Future<void> choseDate({required DateTime dateTime, DateTime ?date,bool isStartDate = false}) async {
                  final  DateTime? picked   = await showDatePicker(
                    ///Tell usman that we need to optimised this code to the day user register to the app anyway he is not giving me enough time to work on this.
                    context: context,
                    initialDate:DateTime(dateTime.year, dateTime.month, dateTime.day ),
                    firstDate: DateTime(dateTime.year , dateTime.month , isStartDate? dateTime.day -20: dateTime.day ),
                    lastDate: DateTime(dateTime.year , dateTime.month, isStartDate? dateTime.day:DateTime.now().day ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const  ColorScheme.light(
                            primary: fagoSecondaryColorWithOpacity10, // header background color
                            onPrimary: fagoSecondaryColor, // header text color
                            onSurface: black, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: fagoSecondaryColor, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if(isStartDate){
                    if (picked != null && picked != date) {
                      setState((){
                        startDate = picked;
                        startDateString =  formatDate(picked , [yyyy, '-', mm, '-', dd]).toString();
                      });
                    }
                  }
                  else{
                    if (picked != null && picked != date) {
                      setState((){
                        //  2023-06-06
                        endDate = picked;
                        endDateDateString =  formatDate(picked , [yyyy, '-', mm, '-', dd]).toString();
                      });
                    }
                  }

                }
                return   Container(
                  color: white,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 2.h,),
                      Center(
                        child: Container(
                          color: fagoSecondaryColor,
                          width: 38.w,
                          height: 3,
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Text('Select Transaction Type',style: Constant().textStyle(size: 18, weight: FontWeight.w600,color: stepsColor)),
                      SizedBox(height: 2.h,),
                      //isFilterLoading?LoadingWidget():
                      SizedBox(
                        height: 4.3.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _txFilterModel?.data.transactionFilter.length,
                            itemBuilder: (context, i){
                              return GestureDetector(
                                onTap: (){
                                  setState((){
                                    filter = _txFilterModel!.data.transactionFilter[i].name;
                                    index = i+1;
                                  });
                                },
                                child: Constant().chip(text: _txFilterModel!.data.transactionFilter[i].name, borderColor: index == i+1?fagoGreenColor:fagoSecondaryColor, textColor: index == i+1? fagoGreenColor: black,color: index == i+1? true:false),
                              );
                            }),
                      ),
                      SizedBox(height: 3.h,),
                      Row(
                        children: [
                          date(text2: 'From',onTap: (){
                            choseDate(dateTime: DateTime.now(),date: startDate,isStartDate: true);
                          }, text: startDateString.isEmpty?'DD/MM/YYY':startDateString),
                          SizedBox(width: 2.7.w,),
                          date(text2: 'To',onTap: (){
                            if(startDateString.isEmpty){
                              Get.snackbar('Error', 'Chose Start Date to proceed',colorText: white,backgroundColor: fagoSecondaryColor);
                            }else{
                              choseDate(dateTime: startDate,date: endDate,isStartDate: false);
                            }
                          }, text: endDateDateString.isEmpty?'DD/MM/YYY':endDateDateString),
                        ],
                      ),
                      SizedBox(height: 3.h,),
                      GestureDetector(
                        onTap: (){
                          if(startDateString.isEmpty){
                            Get.snackbar('Error', 'Chose Start Date to proceed',colorText: white,backgroundColor: fagoSecondaryColor);
                          }else if(endDateDateString.isEmpty){
                            Get.snackbar('Error', 'Chose End Date to proceed',colorText: white,backgroundColor: fagoSecondaryColor);
                          }else{
                            Navigator.of(context).pop();
                            _transactionController.getTransactionHistory(type: 2,endDate: endDateDateString ,filter: filter,startDate:  startDateString);
                          }
                        },
                        child: Center(
                          child: AuthButtons(
                            form: true,
                            text: "Apply",
                            //route: const DashboardHome(),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h,),

                    ],
                  ),
                );
              });
        }
    );

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
    return SizedBox(
      child: Padding(
        padding:  EdgeInsets.only(bottom: 2.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: AutoSizeText(
                              //  'yooo',
                              widget.item.transactionType! == TransactionType.DEBIT ? 'Transfer to ${widget.item.toFrom}' : 'Transfer from ${widget.item.toFrom}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
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
                                      //'yo 2',
                                      widget.item.transactionType! == TransactionType.DEBIT ? 'Debit' : 'Credit',
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
                                        widget.item.transactionStatus == TransactionStatus.SUCCESS ? 'Success' : 'pending',
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
                            const AutoSizeText('Narration',
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
                              style: Constant().textStyle(size: 14, weight: FontWeight.w400,color: stepsColor),
                              maxLines: 1,
                            ),
                            SizedBox(height: 1.h,),
                            AutoSizeText('Reference',
                              style: Constant().textStyle(size: 11, weight: FontWeight.w400,color: stepsColor),
                             ),
                          SizedBox(height: 0.5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                widget.item.reference.toString(),
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: stepsColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      FlutterClipboard.copy(widget.item.reference.toString()).then((value){
                                        Get.snackbar('Success', 'Reference number copied successfully',backgroundColor: fagoGreenColor,colorText: white);
                                      });
                                    },
                                    child: SvgPicture.asset('assets/icons/copy-svgrepo-com 1.svg',))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Image.memory(_imageFile!)
                  ],
                ),
              ),
            ),
            Constant().btn(color: buttonColor,text: 'Share Payment Receipt',img: 'assets/icons/share.png',onTap: (){
              shareImage();
            }),
            const SizedBox(height: 10),
            Constant().btn(color: fagoPrimaryColor,text: 'Download Receipt',img: 'assets/icons/download.png',onTap: (){
              _saveImage();
            }),
          ],
        ),
      ),
    );
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
  _saveImage()async{
    await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((image) async{
      if(image != null){
         await ImageGallerySaver.saveImage(
          image,
          quality: 60,
          name: "hello",
        );
      }else{
        if(kDebugMode){
          print('Unable to save image');
        }
      }
    });
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
