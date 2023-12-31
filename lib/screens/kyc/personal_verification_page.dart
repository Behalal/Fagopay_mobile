import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/kyc/countdown_page2.dart';
import 'package:fagopay/screens/kyc/identity_verification.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileKycPage extends StatefulWidget {
  const ProfileKycPage({
    super.key,
  });

  @override
  State<ProfileKycPage> createState() => _ProfileKycPageState();
}

class _ProfileKycPageState extends State<ProfileKycPage> {
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> Function() requestPermissions = () async {
    await Permission.camera.request().isGranted;

    await Permission.microphone.request();
  };

  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "KYC Verification ",
              // backRoute: MakeRequest(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          'Enjoy more access to our services when you verify your identity.',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: stepsColor,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight, children: [
                          SvgPicture.asset('assets/icons/Ellipse 278.svg',color:_userController.user?.kycVerified == 1?fagoGreenColor: fagoPrimaryColor,),
                          SvgPicture.asset('assets/icons/Ellipse 279.svg',color:_userController.user?.kycVerified == 1?fagoGreenColor: fagoPrimaryColor,),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 3.h),
                            // height: 27.h,
                            width: Get.width,
                            color: _userController.user?.kycVerified == 1?fagoGreenColor.withOpacity(0.2): fagoSecondaryColorWithOpacity10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  'Verify your BVN',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: stepsColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: _userController.user?.kycVerified == 1?fagoGreenColorWithOpacity10: fagoSecondaryColorWithOpacity10,
                                    //  color: fagoSecondaryColorWithOpacity10,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color:_userController.user?.kycVerified == 1?fagoGreenColor: fagoSecondaryColor)
                                    ),
                                  child:  Text(
                                    'BVN Verification',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: _userController.user?.kycVerified == 1 ? fagoGreenColor: fagoSecondaryColor,
                                     // color: fagoSecondaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                const AutoSizeText(
                                  'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: signInPlaceholder,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                _userController.user?.kycVerified == 1?Container() :InkWell(
                                  onTap: () {
                                    FlutterIdentityKyc.showWidget(
                                      InputParameters(
                                        context: context,
                                        merchantKey: "tcusaxtpg2fscbixhdsz:IJd6cBRH3RCubl4iXGQZ0-bH-zI",
                                        firstName: 'demo',
                                        lastName: 'demo',
                                        email: "demo@domainame.com",
                                        userRef: _userController.user!.id,
                                        onCancel: (response) {
                                          if (kDebugMode) {
                                            print(response);
                                          }
                                        },
                                        onVerified: (response) {
                                          Get.to(() => const CountdownPage2());
                                          if (kDebugMode) {
                                            print(response);
                                          }
                                        },
                                        onError: (error) => print(error),
                                      ),
                                    );

                                    // Get.to((const IdentityPassPage()));
                                  },
                                  child: Container(
                                    height: 5.h,
                                    width: 20.5.h,
                                    decoration: BoxDecoration(
                                        color: fagoSecondaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: fagoSecondaryColor)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/verify_pre.svg'),
                                        const AutoSizeText(
                                          'Continue',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/verify_suxf.svg')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 3.h,
                        ),
                      //  _userController.user?.hasGovernmentIdentity == 1 ? Container():
                        GestureDetector(
                          onTap: (){
                            if (_userController.user?.hasGovernmentIdentity != 1) {
                              Get.to(() => const IdentificationVerification());
                              return;
                            }
                          },
                          child: Stack(alignment: Alignment.bottomRight,
                              children: [
                            SvgPicture.asset('assets/icons/Ellipse 278.svg',color:_userController.user?.hasGovernmentIdentity == 1?fagoGreenColor: fagoPrimaryColor,),
                            SvgPicture.asset('assets/icons/Ellipse 279.svg',color:_userController.user?.hasGovernmentIdentity == 1?fagoGreenColor: fagoPrimaryColor,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.h, vertical: 3.h),
                              // height: 27.h,
                              width: Get.width,
                              color: _userController.user?.hasGovernmentIdentity == 1?fagoGreenColor.withOpacity(0.2): fagoSecondaryColorWithOpacity10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    'Upgrade your Limit',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: stepsColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: _userController.user?.kycVerified == 1?fagoGreenColorWithOpacity10: fagoSecondaryColorWithOpacity10,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color:_userController.user?.kycVerified == 1?fagoGreenColor: fagoSecondaryColor)
                                  ),
                                    child:  Text(
                                      'Government ID Verification',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: _userController.user?.kycVerified == 1?fagoGreenColor: fagoSecondaryColor,

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  const AutoSizeText(
                                    'Enjoy more of our services when you verify your ID to upgrade your account.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: signInPlaceholder,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  _userController.user?.hasGovernmentIdentity == 1?Container():Container(
                                    height: 5.h,
                                    width: 20.5.h,
                                    decoration: BoxDecoration(
                                        color: fagoSecondaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: fagoSecondaryColor)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/verify_pre.svg'),
                                        const AutoSizeText(
                                          'Continue',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          ),
                                        ),
                                        SvgPicture.asset('assets/icons/verify_suxf.svg')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
