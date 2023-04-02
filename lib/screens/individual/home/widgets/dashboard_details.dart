// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/home/wallets/fund_wallet.dart';

class DashBoardDetails extends StatefulWidget {
  final String? firstname;
  final String? accountType;
  final AccountDetail? accountDetails;

  const DashBoardDetails({
    Key? key,
    this.firstname,
    this.accountType,
    this.accountDetails,
  }) : super(key: key);

  @override
  State<DashBoardDetails> createState() => _DashBoardDetailsState();
}

class _DashBoardDetailsState extends State<DashBoardDetails> {
  late bool balanceVisible;

  @override
  void initState() {
    balanceVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String notVisibleText = "******";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.h,
          // height: 30.h,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            linearGradient2,
            linearGradient1,
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 1.w,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 55, bottom: 1),
                      width: 95.w,
                      height: 20.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/image 1.png"),
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: [
                              Positioned(
                                top: 6.2.h,
                                width: 13.w,
                                height: 60.09,
                                left: 4.w,
                                child: Image.asset(
                                    "assets/images/sign_in_vector 1.png"),
                              ),
                              Positioned(
                                top: 9.5.h,
                                width: 13.w,
                                height: 95.12,
                                left: 4.w,
                                child: Image.asset(
                                  "assets/images/sign_in_vector 2.png",
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                width: 13.w,
                                height: 60.09,
                                left: 6.w,
                                child: Image.asset(
                                  "assets/images/sign_in_vector 3.png",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width: 7.w,
                                ),
                              ),
                              const CircleAvatar(
                                radius: 25, // Image radius
                                backgroundImage:
                                    AssetImage('assets/images/fago(2).png'),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: white,
                                          ),
                                          children: [
                                            const TextSpan(text: 'Hello'),
                                            TextSpan(
                                              text: ' ${widget.firstname}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: const [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/box.png"),
                                            height: 20,
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: white,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    //width: 30.w,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 3),
                                      child: AutoSizeText(
                                        widget.accountDetails!.accountType!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 7,
                                          fontWeight: FontWeight.w500,
                                          color: black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.qr_code_scanner,
                                size: 20,
                                color: white,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Icon(
                                Icons.notifications,
                                size: 20,
                                color: white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.w, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText(
                      "Wallet Balance",
                      style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          (balanceVisible)
                              ? ((widget.accountDetails == null)
                                  ? "$currencySymbol 0.00"
                                  : "$currencySymbol ${widget.accountDetails!.balance}.00")
                              : notVisibleText,
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: white),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              balanceVisible = !balanceVisible;
                            });
                          },
                          child: Icon(
                            (balanceVisible)
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: white,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.accountDetails != null)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    widget.accountDetails!.bankName!,
                                    style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: white),
                                  ),
                                  SizedBox(
                                    width: 1.5.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      print(
                                        widget.accountDetails!.balance,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.copy,
                                      color: white,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 0.2.h,
                              ),
                              AutoSizeText(
                                widget.accountDetails!.accountNumber!,
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: white),
                              ),
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => FundWallet(
                                        accountDetails: widget.accountDetails!,
                                      )));
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  image:
                                      AssetImage("assets/images/fund_icon.png"),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                const AutoSizeText(
                                  "Fund Account",
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
