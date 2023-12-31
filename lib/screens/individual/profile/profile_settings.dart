// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/authentication/dispute_screen.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/individual/profile/account_limit.dart';
import 'package:fagopay/screens/individual/profile/change_passcode.dart';
import 'package:fagopay/screens/individual/profile/change_password.dart';
import 'package:fagopay/screens/individual/profile/edit_profile.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/kyc/personal_verification_page.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _userUcontroller = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();
  int? transactionType;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  checkBiometricsStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    isSwitched = await LocalCachedData.instance.getEnableBiometricStatus() ?? false;
    setState(() {});
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }


  @override
  void initState() {
    checkBiometricsStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(_userUcontroller.user!.nextofkin);
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 4.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const ProgressStyle(
                  //   stage: 0,
                  //   pageName: "Transactions",
                  //   // backRoute: MakeRequest(),
                  SizedBox(height: 8.h),
                  const AutoSizeText(
                    'Profile Settings',
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
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.h, horizontal: 2.5.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const EditProfile());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  width: Get.width,
                                  height: 10.h,
                                  decoration: const BoxDecoration(
                                      color: fagoPrimaryColorWithOpacity10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            // _userUcontroller.switchedAccountType == 2 ? '${_companyController.company?.companyName?.substring(0, 1)}'??'' :
                                            '${_userUcontroller.user?.firstName?.substring(0, 1) ?? ""}${_userUcontroller.user?.lastName?.substring(0, 1) ?? ""}',
                                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,wordSpacing: 2),),
                                        ),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  _userUcontroller.user!.firstName ?? '',
                                                  style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.5.h,
                                                ),
                                                AutoSizeText(_userUcontroller.user!.lastName ?? '',
                                                  style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AutoSizeText(
                                              _userUcontroller.user!.email ?? '',
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: welcomeText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                            'assets/icons/arrow_front.svg')
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Security Settings',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                width: Get.width,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: fagoPrimaryColorWithOpacity10,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/face_icon.svg'),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      const AutoSizeText(
                                        'Face ID Authentication',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: welcomeText,
                                        ),
                                      ),
                                      const Spacer(),
                                      Transform.scale(
                                          scale: 1.5,
                                          child: Switch(
                                            onChanged: (value) async {
                                              Get.put<LocalCachedData>(await LocalCachedData.create());
                                               await LocalCachedData.instance.cacheEnableBiometricStatus(status: value);
                                              isSwitched = value;
                                              setState(() {});
                                            },
                                            value: isSwitched,
                                            activeColor: Colors.red,
                                            activeTrackColor: Colors.white,
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor: Colors.red,
                                          )),
                                    ]),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ForgotPassword(
                                        pinCode: '',
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: Get.width,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      color: fagoPrimaryColorWithOpacity10,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/change_passcode.svg'),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        const AutoSizeText(
                                          'Change Password',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: welcomeText,
                                          ),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                            'assets/icons/arrow_front.svg')
                                      ]),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ChangePassCode());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: Get.width,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      color: fagoPrimaryColorWithOpacity10,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/change_passcode.svg'),
                                        SizedBox(
                                          width: 1.h,
                                        ),
                                        const AutoSizeText(
                                          'Change Passcode',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: welcomeText,
                                          ),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                            'assets/icons/arrow_front.svg')
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'General Settings',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                width: Get.width,
                             //   height: 30.h,
                                decoration: const BoxDecoration(
                                  color: fagoPrimaryColorWithOpacity10,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() =>  const NextOfKinPage());
                                        },
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/Group 90.svg'),
                                              SizedBox(
                                                width: 2.h,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const AutoSizeText(
                                                    'Next of Kin',
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: welcomeText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  AutoSizeText(
                                                    _userUcontroller.user!.nextofkin?.fullName ?? '',
                                                    style: const TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: welcomeText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                  'assets/icons/arrow_front.svg')
                                            ]),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                                      child: InkWell(
                                        onTap: () {
                                          // _userUcontroller.user?.kycVerified ==1 && _userUcontroller.user?.hasGovernmentIdentity == 1? null :
                                          Get.to(() => const ProfileKycPage());
                                        },
                                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/icons/Group 90.svg'),
                                              SizedBox(
                                                width: 2.h,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const AutoSizeText(
                                                    'KYC',
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: welcomeText,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h,),
                                                  Container(height: 2.5.h, width: 14.5.h,
                                                    decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(25)),
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      _userUcontroller.user?.kycVerified ==1 && _userUcontroller.user?.hasGovernmentIdentity == 1? "Completed" :
                                                      'Not completed',
                                                      style: const TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: fagoSecondaryColor,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset('assets/icons/arrow_front.svg')
                                            ]),
                                      ),
                                    ),
                                    const Divider(),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => const AccountLimit());
                                      },
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/Group 90.svg'),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Account Limit',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  'Be aware of your account\nthreshold',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SvgPicture.asset(
                                                'assets/icons/arrow_front.svg')
                                          ]),
                                    ),
                                    const Divider(),
                                    InkWell(
                                      onTap: () {
                                        Get.to(()=> const DisputeScreen());
                                      },
                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(height: 30, width: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/images/dispute_icon.png', height: 25, width: 25,),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Submit a Dispute',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  'Tell us about your challenges',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: welcomeText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SvgPicture.asset(
                                                'assets/icons/arrow_front.svg')
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                          title: "",
                                          middleText: "",
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          content: logOutDialog());
                                    },
                                    child: Container(
                                      height: 4.h,
                                      width: 11.5.h,
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: fagoSecondaryColor)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const AutoSizeText(
                                            'Logout',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: fagoSecondaryColor,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              'assets/icons/log_out.svg')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        )),
                  ),
                ])));
  }

  Widget logOutDialog() {
    return SizedBox(
      height: 240,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/icons/logout_dialogue.svg'),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            " Logout",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            "Do you really want to leave?",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: stepsColor,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            'You will have to authenticate your \naccount again before you can get \naccess to it to confirm it’s really you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: stepsColorWithOpacity55,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _userUcontroller.switchedAccountType = 1;
                    SecureStorage.deleteUserIdentifier();
                    SecureStorage.deleteUserToken();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const SignIn()),
                        (route) => false);
                  },
                  child: Container(
                    width: 130,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        const AutoSizeText(
                          "Confirm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 130,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonColor),
                      color: white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        const AutoSizeText(
                          "Cancel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w600,
                            color: buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
