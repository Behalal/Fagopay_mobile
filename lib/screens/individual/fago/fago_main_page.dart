import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/widgets/info_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import '';
import '../../constants/colors.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class FagoMainPage extends StatefulWidget {
  final UserDetail userDetail;
  final AccountDetail accountDetail;
  const FagoMainPage({
    super.key, required this.userDetail, required this.accountDetail,
  });

  @override
  State<FagoMainPage> createState() => _FagoMainPageState();
}

class _FagoMainPageState extends State<FagoMainPage> {
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();

  showKycDialog() {
    var duration = const Duration(seconds: 1);
    return Timer(duration, ()=>
        showInformationDialog(Get.context!, "You don't have transaction record. Kindly complete your kyc verification to make a transaction", "No KYC Verification"));
  }


  @override
  void initState() {
    _userController.user?.kycVerified != 1 ?
    showKycDialog() : null;
    super.initState();
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 8.h, bottom: 2.h, right: 5.w, left: 5.w), color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    'My QR Code',
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
                    height: 2.h,
                  ),
                  const Align(alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Scan the QR Code ",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Your customers can use any bank app to scan the QR code below to pay you.",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: inactiveTab,
                    ),
                  ),
                ]),
          ),
          RepaintBoundary(
            key: scr,
            child: Container(color: Colors.white,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: fagoSecondaryColorWithOpacity10,
                    child: Text(
                      _userController.switchedAccountType == 2 ? '${_companyController.company?.companyName?.substring(0, 1)}'??'' :
                      '${_userController.user?.firstName?.substring(0, 1) ?? ""}${_userController.user?.lastName?.substring(0, 1) ?? ""}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,wordSpacing: 2),),
                  ),
                  AutoSizeText(_userController.switchedAccountType == 2 ? "${_companyController.company?.companyName?.toUpperCase()}" : "${_userController.user?.firstName?.toUpperCase()} ${_userController.user?.lastName?.toUpperCase()}",
                    style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: inactiveTab,
                    ),),
                  AutoSizeText(_userController.switchedAccountType == 2 ? "${_companyController.company?.account?.accountNumber} | ${_companyController.company?.account?.bankName}" :
                  "${_userController.user?.accountdetail?.accountNumber} | ${_userController.user?.accountdetail?.bankName}",
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: inactiveTab,
                      )),
                  _userController.switchedAccountType == 2 ?
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: QrImageView(
                            data: '${_companyController.company?.companyName}\n${_companyController.company?.account?.accountNumber}\n${_companyController.company?.account?.accountName}',
                            version: 4,
                            gapless: false,
                            size: 200.0,
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(80, 80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) :
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: QrImageView(
                            data: '${_userController.user?.firstName} ${_userController.user?.lastName}\n${_userController.user?.accountdetail?.accountNumber}\n${_userController.user?.accountdetail?.accountName}',
                            version: 4,
                            gapless: false,
                            size: 200.0,
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(80, 80),
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
          SizedBox(height: 3.h,),
          GestureDetector(
              onTap: (){
                takeScreenShot();
                Get.snackbar("Success", "Saved to gallery", colorText: Colors.white, backgroundColor: fagoGreenColor);
              },
              child: Center(
                child: AuthButtons(
                  form: true,
                  text: "Download QR Code",
                ),
              )),
        ],
      ),
    );
  }
}
