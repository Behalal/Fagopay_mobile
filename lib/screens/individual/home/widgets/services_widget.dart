import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/screens/individual/bills/qr_code/create_qr_code.dart';
import '../../../../controllers/user_controller.dart';
import '../../../constants/colors.dart';
import '../../bills/data.dart';
import '../../bills/electricity.dart';
import '../../bills/internet.dart';
import '../../bills/swap_airtime.dart';
import '../../bills/tv.dart';
import '../../refer_and_win/refer_page.dart';
import '../../requests/requests.dart';
import '../../transactions/fago_to_bank.dart';
import '../../transactions/fago_to_fago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Services {
  final String image;
  final String itemName;
  final String? bill;
  final Widget? route;
  const Services(
      {required this.image, this.route, required this.itemName, this.bill});
}

final _userController = Get.find<UserController>();
final _companyController = Get.find<CompanyController>();

List<Services> services = [
  Services(
    image: 'assets/icons/new_tansfer_icon.svg',
    itemName: 'Transfer',
    route: FagoToBank(
      userDetails: _userController.user!,
      accountDetails: _userController.switchedAccountType == 2
          ? _companyController.company!.accountDetails!
          : _userController.userAccountDetails!,
    ),
  ),
  const Services(
    image: 'assets/icons/new_paymentLink_icon.svg',
    itemName: 'Fago 2 Fago',
    route: FagoToFago(),
  ),
  const Services(
    image: 'assets/icons/new_scanToPay_icon.svg',
    itemName: 'Scan to Pay',
    route: CreateQrCode(),
  ),
  const Services(
    image: 'assets/icons/new_requestMoney_icon.svg',
    itemName: 'Request Money',
    route: RequestHome(),
  ),
  const Services(
    image: 'assets/icons/new_airtime_icon.svg',
    itemName: 'Airtime & Data',
    route: BuyData(),
  ),
  const Services(
      image: 'assets/icons/new_payInternet_icon.svg',
      itemName: 'Bills Payment',
      route: null,
      bill: 'special'),
  const Services(
    image: 'assets/icons/new_swapAirtime_icon.svg',
    itemName: 'Swap Airtime',
    route: SwapAirtime(),
  ),
  const Services(
    image: 'assets/icons/new_payment_link.svg',
    itemName: 'Payment Link',
    route: ReferAndEarn(),
  )
];

// class SelectCard extends StatefulWidget {
//   const SelectCard({this.onclick, this.title, this.icon}) : super(key: key);

//   @override
//   State<SelectCard> createState() => _SelectCardState();
// }

// class _SelectCardState extends State<SelectCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         color: Colors.orange,
//         child: Center(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                     child: Icon(widget.choice.icon,
//                         size: 50.0, color: textStyle.color)),
//                 Text(widget.choice.title, style: textStyle),
//               ]),
//         ));
//   }
// }

class BillsPayment extends StatelessWidget {
  const BillsPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.h),
      height: Get.height * .5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.4.h,
              width: 10.h,
              color: fagoSecondaryColor,
            ),
            SizedBox(
              height: 2.h,
            ),
            const AutoSizeText(
              "Bills Payment",
              style: TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: fagoSecondaryColor,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Divider(),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const Electricity());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/Group 12793.svg"),
                  const AutoSizeText(
                    "Pay Electricity",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: stepsColor,
                    ),
                  ),
                  SizedBox(
                    width: 9.h,
                  ),
                  SvgPicture.asset("assets/icons/arrow_front.svg"),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Divider(),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const TVSubscription());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/Group 12794.svg"),
                  const AutoSizeText(
                    "Pay Cable TV",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: stepsColor,
                    ),
                  ),
                  SizedBox(
                    width: 9.h,
                  ),
                  SvgPicture.asset("assets/icons/arrow_front.svg"),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Divider(),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const Internrt());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/Group 12795.svg"),
                  const AutoSizeText(
                    "Pay Internet",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: stepsColor,
                    ),
                  ),
                  SizedBox(
                    width: 9.h,
                  ),
                  SvgPicture.asset("assets/icons/arrow_front.svg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
