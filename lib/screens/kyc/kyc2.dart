import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../models/kyc_model.dart';
import '../authentication/account_creation/widgets/current_step.dart';
import '../authentication/widgets/auth_buttons.dart';
import '../constants/colors.dart';
import 'face_verify.dart';
import 'kyc1.dart';
import 'kyc_details.dart';

class BvnVerification extends StatefulWidget {
  const BvnVerification({super.key});

  @override
  State<BvnVerification> createState() => BvnVerificationState();
}

class BvnVerificationState extends State<BvnVerification> {
  late bool otpSelected;
  late bool faceSelected;
  @override
  void initState() {
    otpSelected = true;
    faceSelected = false;
    super.initState();
  }

  final TextEditingController bvnValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentStep(
                  step: "2",
                  backRoute: const KycVerfication(
                    accountType: 'individual',
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  "Provide your BVN",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  "You need to provide us your BVN so we can verify your identity and prevent impersonation.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    controller: bvnValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: stepsColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: textBoxBorderColor,
                          width: 1.0,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      hintText: "Enter Your BVN",
                      hintStyle: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder,
                      ),
                      prefixIcon: const Icon(
                        Icons.shield_outlined,
                        color: fagoSecondaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  "How do you want us to verify it’s your BVN?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BvnVerification()));
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              otpSelected = true;
                              faceSelected = false;
                            });
                          },
                          child: SizedBox(
                            width: 85.w,
                            height: 15.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.h, vertical: 3),
                              decoration: const BoxDecoration(
                                  color: fagoSecondaryColorWithOpacity10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Verify by OTP",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Work Sans",
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        const Text(
                                          "A verification code would be sent to your registered number.",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Work Sans",
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  (!otpSelected)
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/images/Icon-dot.png"))
                                      : const Image(
                                          image: AssetImage(
                                              "assets/images/check_Icon.png")),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BvnVerification()));
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              faceSelected = true;
                              otpSelected = false;
                            });
                          },
                          child: SizedBox(
                            width: 85.w,
                            height: 15.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.h, vertical: 3),
                              decoration: const BoxDecoration(
                                  color: fagoSecondaryColorWithOpacity10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Verify using my Face",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Work Sans",
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        const Text(
                                          "You will be presented a camera which will scan your face to verify you own the BVN",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Work Sans",
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  (!faceSelected)
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/images/Icon-dot.png"))
                                      : const Image(
                                          image: AssetImage(
                                              "assets/images/check_Icon.png")),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                  child: GestureDetector(
                    onTap: (() {
                      if (bvnValue.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Kindly enter your BVN",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Kindly enter your BVN'),
                        //   ),
                        // );
                      } else {
                        KycDetailsValue.setbvn = bvnValue.text;
                        if (otpSelected) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const KycDetailsScreen()));
                        } else {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const FaceVerify()));
                        }
                      }
                    }),
                    child: AuthButtons(
                      form: true,
                      hasImage: "assets/images/bi_shield-lock-white.png",
                      text: "Verify BVN",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
