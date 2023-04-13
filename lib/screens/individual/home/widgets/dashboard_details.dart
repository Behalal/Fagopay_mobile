// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/business/home/home.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/home/wallets/fund_wallet.dart';

class DashBoardDetails extends StatefulWidget {
  final User user;
  final String? accountType;
  final AccountDetail accountDetails;

  const DashBoardDetails({
    Key? key,
    required this.user,
    this.accountType,
    required this.accountDetails,
  }) : super(key: key);

  @override
  State<DashBoardDetails> createState() => _DashBoardDetailsState();
}

class _DashBoardDetailsState extends State<DashBoardDetails> {
  bool balanceVisible = true;
  String notVisibleText = "******";

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.only(top: 55, bottom: 2),
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
                                              text: ' ${widget.user.firstName}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      PopupMenuButton<String>(
                                        offset: const Offset(0, 50),
                                        initialValue: widget.accountType ==
                                                "Individual"
                                            ? AccountType.individual.toString()
                                            : AccountType.business.toString(),
                                        onSelected: (selectedItem) {
                                          if (selectedItem ==
                                              AccountType.business.toString()) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BusinessHome(
                                                  userDetails: widget.user,
                                                  accountDetails:
                                                      widget.accountDetails,
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DashboardHome(
                                                userDetails: widget.user,
                                                accountDetails:
                                                    widget.accountDetails,
                                              ),
                                            ),
                                          );
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: AccountType.individual
                                                .toString(),
                                            child: const Text('Individual'),
                                          ),
                                          PopupMenuItem<String>(
                                            value:
                                                AccountType.business.toString(),
                                            child: const Text('Business'),
                                          ),
                                        ],
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.center,
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
                                        widget.accountType!,
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
                              GestureDetector(
                                onTap: () {
                                  // SecureStorage.deleteUserIdentifier();
                                  // SecureStorage.deleteUserToken();
                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const SignIn()),
                                  //     (route) => false);
                                },
                                child: const Icon(
                                  Icons.notifications,
                                  size: 20,
                                  color: white,
                                ),
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
                padding: EdgeInsets.only(left: 9.w, bottom: 15),
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
                        color: white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          (balanceVisible)
                              ? ((widget.accountDetails.balance.toString() ==
                                      "")
                                  ? "$currencySymbol 0.00"
                                  : "$currencySymbol ${widget.accountDetails.balance}.00")
                              : notVisibleText,
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: white),
                        ),
                        SizedBox(
                          width: 2.w,
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
                        if (widget.accountDetails.accountName != "")
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    widget.accountDetails.bankName!,
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
                                    onTap: () {},
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
                                widget.accountDetails.accountNumber!,
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => FundWallet(
                                    accountDetails: widget.accountDetails,
                                  ),
                                ),
                              );
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

enum AccountType { individual, business }
