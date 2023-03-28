import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/models/register_request/register.model.dart';
import 'package:fagopay/repository/controllers/login_controller_provider.dart';
import 'package:fagopay/screens/authentication/account_creation/select_type.dart';
import 'package:fagopay/screens/authentication/account_creation/verify_code.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class SelectVerificationType extends ConsumerStatefulWidget {
  const SelectVerificationType({super.key});

  @override
  ConsumerState<SelectVerificationType> createState() =>
      _SelectVerificationTypeState();
}

class _SelectVerificationTypeState
    extends ConsumerState<SelectVerificationType> {
  int currentIndex = 0;
  late bool usePhone;
  late bool useEmail;
  late bool _isLoading;

  @override
  void initState() {
    usePhone = true;
    useEmail = false;
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    Functions function = Functions();
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentStep(step: "2", backRoute: const SelectType()),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            usePhone = true;
                            useEmail = false;
                          });
                        },
                        child: Container(
                          width: 38.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: (usePhone) ? fagoSecondaryColor : white,
                              border: Border.all(
                                color: (usePhone)
                                    ? fagoSecondaryColor
                                    : fagoSecondaryColorWithOpacity,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Center(
                              child: AutoSizeText(
                                "Use Phone Number",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: (usePhone) ? white : inactiveTab,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            usePhone = false;
                            useEmail = true;
                          });
                        }),
                        child: Container(
                          width: 38.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: (useEmail) ? fagoSecondaryColor : white,
                              border: Border.all(
                                color: (useEmail)
                                    ? fagoSecondaryColor
                                    : fagoSecondaryColorWithOpacity,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Center(
                              child: AutoSizeText(
                                "Use Email Address",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (useEmail) ? white : inactiveTab,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: AutoSizeText(
                      (usePhone) ? "Enter Phone Number" : "Enter your Email",
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: fagoSecondaryColor,
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                    width: 80.w,
                    child: AutoSizeText(
                      (usePhone)
                          ? "Within some few step, your account will be all set and ready for use. Kindly input your Phone Number for verification:"
                          : "Within some few step, your account will be all set and ready for use. Kindly input your email address for verification",
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: inactiveTab,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        controller: controller,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: (usePhone)
                              ? "Enter your phone number"
                              : "Enter your email",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                          prefixIcon: Stack(
                            alignment: AlignmentDirectional.center,
                            children: const [
                              Image(
                                  image:
                                      AssetImage("assets/images/shield.png")),
                              Image(image: AssetImage("assets/images/key.png")),
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.5.w),
                  child: SizedBox(
                    width: 80.w,
                    child: AutoSizeText(
                      (!usePhone)
                          ? "A verification code would be sent to your  email address."
                          : "A verification code would be sent to your  number.",
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: verificationCodeText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                  child: GestureDetector(
                    onTap: (() {
                      if (_isLoading != true) {
                        if (controller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kindly Insert all fields'),
                            ),
                          );
                        } else if (usePhone &&
                            !function.validatePhone(controller.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Kindly Insert a valid phone number'),
                            ),
                          );
                        } else if (useEmail &&
                            !function.validateEmail(controller.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Kindly Insert a valid email address'),
                            ),
                          );
                        } else {
                          String verificationDataValue = registrationData
                              .setVerification = controller.text;
                          setState(() {
                            _isLoading = true;
                          });
                          ref
                              .read(loginControllerProvider.notifier)
                              .selectAccountType(registrationData.accountType,
                                  verificationDataValue)
                              .then((value) {
                            if (value.code != null && value.code != 200) {
                              setState(() {
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.error!),
                                ),
                              );
                            } else {
                              registrationData.setId = value.identifier!;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.message!),
                                ),
                              );
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const VerifyCodeSent(),
                                    ),
                                  );
                                });
                              });
                            }
                          });
                        }
                      }
                    }),
                    child: AuthButtons(
                      hasImage:
                          (_isLoading) ? "assets/images/loader.gif" : null,
                      color: (_isLoading) ? signInPlaceholder : null,
                      imageWidth: (_isLoading) ? 50 : null,
                      imageheight: (_isLoading) ? 30 : null,
                      form: true,
                      text: (_isLoading) ? "" : "Verify",
                    ),
                  ),
                ),
              ])),
    ));
  }
}
