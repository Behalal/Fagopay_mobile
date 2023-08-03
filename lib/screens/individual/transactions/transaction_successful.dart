import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/colors.dart';
import '../../widgets/navigation_bar.dart';
import 'dart:ui' as ui;

class TransactionSuccessful extends StatefulWidget {
  final String? transactionType;
  final String? amount;
  final String? number;
  final String? action;
  const TransactionSuccessful(
      {super.key, this.action, this.amount, this.number, required this.transactionType});

  @override
  State<TransactionSuccessful> createState() => _TransactionSuccessfulState();
}

class _TransactionSuccessfulState extends State<TransactionSuccessful> {
  var scr = GlobalKey();
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
  ScreenshotController screenshotController = ScreenshotController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepaintBoundary(
        key: scr,
        child: Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: AutoSizeText(
                      "Transaction Successful",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                   const Stack(alignment: AlignmentDirectional.center,
                    children: [
                      Image(image: AssetImage("assets/images/success_bg.png"),),
                      Image(image: AssetImage("assets/images/success_mark.png"),),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                   SizedBox(
                    child: AutoSizeText("${widget.transactionType ?? ""} Successful",
                      textAlign: TextAlign.center, style: const TextStyle(fontFamily: "Work Sans", fontSize: 22, fontWeight: FontWeight.w700, color: fagoSecondaryColor,),),
                  ),
                  SizedBox(height: 4.h,),
                  SizedBox(width: 70.w,
                    child: AutoSizeText("You have successfully purchased ${widget.action} worth ${widget.amount} for the number ${widget.number}",
                      textAlign: TextAlign.center, style: const TextStyle(fontFamily: "Work Sans", fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black,),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                      child: GestureDetector(
                        onTap: () {
                          shareImage();
                        },
                        child: Container(padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                          alignment: Alignment.center, decoration: const BoxDecoration(color: buttonColor, borderRadius: BorderRadius.all(Radius.circular(25))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.share, size: 15, color: white,),
                              SizedBox(width: 1.w,),
                              const AutoSizeText("Share Receipt", textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, fontFamily: "Work Sans", fontWeight: FontWeight.w600, color: white),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      child: GestureDetector(
                        onTap: () {
                          takeScreenShot();
                          Get.snackbar("Success", "Saved to gallery", colorText: Colors.white, backgroundColor: fagoGreenColor);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: fagoPrimaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.file_download_sharp,
                                size: 15, color: white,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              const AutoSizeText(
                                "Download",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    color: white),
                              ),
                            ],
                          ),
                        ),
                      )),
                  InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Dashboard()),
                        (Route<dynamic> route) => false),
                    child: const AutoSizeText("Go to Dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontFamily: "Work Sans", fontWeight: FontWeight.w400, color: buttonColor, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
