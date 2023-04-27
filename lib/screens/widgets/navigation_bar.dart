import 'package:auto_size_text/auto_size_text.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model/user.dart';
import '../business/home/home.dart';
import '../individual/fago/fago_main_page.dart';
import '../individual/home/dashboard_home.dart';
import '../individual/profile/profile_settings.dart';
import '../individual/purse/my_purse.dart';
import '../individual/transactions/transaction_history.dart';
import '../kyc/kyc2.dart';
import '../kyc/kyc_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

// class FagoNavigationBar extends StatefulWidget {
//   const FagoNavigationBar({super.key});

//   @override
//   State<FagoNavigationBar> createState() => _FagoNavigationBarState();
// }

// class _FagoNavigationBarState extends State<FagoNavigationBar> {
//   static final _userUcontroller = Get.find<UserController>();
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   final List<Widget> _widgetOptions = <Widget>[
//     DashboardHome(
//       userDetails: _userUcontroller.user!,
//       accountDetails: _userUcontroller.userAccountDetails,
//     ),
//     const Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     const Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//     const Text(
//       'Index 3: Settings',
//       style: optionStyle,
//     ),
//     const Text(
//       'Index 4: profile',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         // fixedColor: fagoSecondaryColor,
//         items: [
//           const BottomNavigationBarItem(
//             // backgroundColor: Fago_secondary_color,
//             icon: Icon(
//               Icons.home,
//               size: 20,
//             ),
//             label: "Home",
//           ),
//           const BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.source,
//                 size: 20,
//               ),
//               label: "Transactions"),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/images/home_nav_logo.png',
//               height: 55,
//               width: 55,
//             ),
//             label: "",
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.credit_card_rounded,
//               size: 20,
//             ),
//             label: "Cards",
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.person,
//               size: 20,
//             ),
//             label: "Profile",
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: fagoSecondaryColor,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final _userUcontroller = Get.find<UserController>();
  int selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardHome(
    userDetails: _userUcontroller.user!,
    accountDetails: _userUcontroller.userAccountDetails,
  );
  bool isclicked = false;

  List<String> selectedIcons = [
    'assets/icons/selected_home.svg',
    'assets/icons/selected_transaction.svg',
    'assets/icons/home_nav_logo.svg',
    'assets/icons/fago_pay_card_icon.svg',
    'assets/icons/selected_profile.svg',
  ];
  List<String> unSelectedIcons = [
    'assets/icons/home_icon.svg',
    'assets/icons/transaction_icon.svg',
    'assets/icons/home_nav_logo.svg',
    'assets/icons/fago_pay_card_icon.svg',
    'assets/icons/profile_icon.svg',
  ];

  List<String> navTitle = [
    'Home',
    'Transaction',
    '',
    'Fagopay Cards',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor().backGround,
      body: buildPages(),
      bottomNavigationBar: Container(
        constraints: const BoxConstraints(),
        height: Get.height * 0.11,
        decoration: const BoxDecoration(
          color: white,
        ),
        child: ListView.builder(
          itemCount: selectedIcons.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            left: Get.width * .04,
            right: Get.width * .04,
            bottom: Get.width * .04,
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  selectedIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == selectedIndex ? 0 : Get.width * .001,
                    right: Get.width * .03,
                    left: Get.width * .03,
                  ),
                  width: Get.width * .128,
                  height: Get.width * .014,
                ),
                index == 2
                    ? SvgPicture.asset(
                        index == selectedIndex
                            ? selectedIcons[index]
                            : unSelectedIcons[index],
                        height: Get.width * .12,
                        // color: index == selectedIndex
                        //     ? AppColor().primaryColorPurple.withOpacity(0.5)
                        //     : Colors.black38,
                      )
                    : SvgPicture.asset(
                        index == selectedIndex
                            ? selectedIcons[index]
                            : unSelectedIcons[index],
                        height: Get.width * .06,
                        // color: index == selectedIndex
                        //     ? AppColor().primaryColorPurple.withOpacity(0.5)
                        //     : Colors.black38,
                      ),
                SizedBox(
                  height: 0.5.h,
                ),
                AutoSizeText(
                  navTitle[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: index == selectedIndex
                        ? fagoSecondaryColor
                        : fagoGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (selectedIndex) {
      case 0:
        return DashboardHome(
          userDetails: _userUcontroller.user!,
          accountDetails: _userUcontroller.userAccountDetails,
        );

      case 1:
        return const TransactionHistoryPage();
      case 2:
        return const FagoMainPage();
      case 3:
        return const MyPurse();
      case 4:
      default:
        return const ProfileSettings();
    }
  }

  // Widget buildButton({VoidCallback? onPress, String? image, String? title}) {
  //   return InkWell(
  //     onTap: onPress,
  //     child: SizedBox(
  //       height: 30,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SvgPicture.asset(
  //             image!,
  //             height: isclicked ? 20 : 18,
  //             // color: isclicked ? AppColor().lightPurple : AppColor().greyColor,
  //           ),
  //           AutoSizeText(
  //             title!,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 10,
  //               fontFamily: "Work Sans",
  //               fontWeight: FontWeight.w400,
  //               color: isclicked
  //                   ? fagoPrimaryColor
  //                   : fagoSecondaryColorWithOpacity,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({
    super.key,
  });

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  static final _userUcontroller = Get.find<UserController>();
  int selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = BusinessHome(
    userDetails: _userUcontroller.user!,
    accountDetails: _userUcontroller.userAccountDetails!,
  );
  bool isclicked = false;

  List<String> selectedIcons = [
    'assets/icons/selected_home.svg',
    'assets/icons/selected_transaction.svg',
    'assets/icons/home_nav_logo.svg',
    'assets/icons/fago_pay_card_icon.svg',
    'assets/icons/selected_profile.svg',
  ];
  List<String> unSelectedIcons = [
    'assets/icons/home_icon.svg',
    'assets/icons/transaction_icon.svg',
    'assets/icons/home_nav_logo.svg',
    'assets/icons/fago_pay_card_icon.svg',
    'assets/icons/profile_icon.svg',
  ];

  List<String> navTitle = [
    'Home',
    'Invoice',
    '',
    'Transactions',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor().backGround,
      body: buildPages(),
      bottomNavigationBar: Container(
        constraints: const BoxConstraints(),
        height: Get.height * 0.11,
        decoration: const BoxDecoration(
          color: white,
        ),
        child: ListView.builder(
          itemCount: selectedIcons.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            left: Get.width * .04,
            right: Get.width * .04,
            bottom: Get.width * .04,
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  selectedIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == selectedIndex ? 0 : Get.width * .003,
                    right: Get.width * .03,
                    left: Get.width * .03,
                  ),
                  width: Get.width * .128,
                  height: Get.width * .014,
                ),
                index == 2
                    ? SvgPicture.asset(
                        index == selectedIndex
                            ? selectedIcons[index]
                            : unSelectedIcons[index],
                        height: Get.width * .12,
                        // color: index == selectedIndex
                        //     ? AppColor().primaryColorPurple.withOpacity(0.5)
                        //     : Colors.black38,
                      )
                    : SvgPicture.asset(
                        index == selectedIndex
                            ? selectedIcons[index]
                            : unSelectedIcons[index],
                        height: Get.width * .06,
                        // color: index == selectedIndex
                        //     ? AppColor().primaryColorPurple.withOpacity(0.5)
                        //     : Colors.black38,
                      ),
                SizedBox(
                  height: 1.h,
                ),
                AutoSizeText(
                  navTitle[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: index == selectedIndex
                        ? fagoSecondaryColor
                        : fagoGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (selectedIndex) {
      case 0:
        return BusinessHome(
          userDetails: _userUcontroller.user!,
          accountDetails: _userUcontroller.userAccountDetails!,
        );

      case 1:
        return const TransactionHistoryPage();
      case 2:
        return const kyc_success();
      case 3:
        return const BvnVerification();
      case 4:
      default:
        return const kyc_success();
    }
  }

  // Widget buildButton({VoidCallback? onPress, String? image, String? title}) {
  //   return InkWell(
  //     onTap: onPress,
  //     child: SizedBox(
  //       height: 30,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SvgPicture.asset(
  //             image!,
  //             height: isclicked ? 20 : 18,
  //             // color: isclicked ? AppColor().lightPurple : AppColor().greyColor,
  //           ),
  //           AutoSizeText(
  //             title!,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 10,
  //               fontFamily: "Work Sans",
  //               fontWeight: FontWeight.w400,
  //               color: isclicked
  //                   ? fagoPrimaryColor
  //                   : fagoSecondaryColorWithOpacity,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
