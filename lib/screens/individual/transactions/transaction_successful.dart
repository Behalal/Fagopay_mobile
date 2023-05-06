import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../constants/colors.dart';
import '../../widgets/navigation_bar.dart';

class TransactionSuccessful extends StatefulWidget {
  final String? amount;
  final String? number;
  final String? action;
  const TransactionSuccessful(
      {super.key, this.action, this.amount, this.number});

  @override
  State<TransactionSuccessful> createState() => _TransactionSuccessfulState();
}

class _TransactionSuccessfulState extends State<TransactionSuccessful> {
  final _userUcontroller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                // width: 65.w,
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
              SizedBox(
                height: 8.h,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  Image(
                    image: AssetImage("assets/images/success_bg.png"),
                  ),
                  Image(
                    image: AssetImage("assets/images/success_mark.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: const SizedBox(
                  // width: 80.w,
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
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SizedBox(
                  width: 70.w,
                  child: AutoSizeText(
                    "You have successfully purchased ${widget.action} worth ${widget.amount} for the number ${widget.number}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: successDescription,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.share,
                            size: 15,
                            color: white,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          const AutoSizeText(
                            "Share Receipt",
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
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  child: GestureDetector(
                    onTap: () {},
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
                            size: 15,
                            color: white,
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
                child: const AutoSizeText(
                  "Go to Dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w400,
                      color: buttonColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
