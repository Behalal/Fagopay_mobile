import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FagoNavigationBar extends StatefulWidget {
  const FagoNavigationBar({super.key});

  @override
  State<FagoNavigationBar> createState() => _FagoNavigationBarState();
}

class _FagoNavigationBarState extends State<FagoNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: fagoSecondaryColor,
        items: [
          const BottomNavigationBarItem(
            // backgroundColor: Fago_secondary_color,
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.source,
                size: 20,
              ),
              label: "Transactions"),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home_nav_logo.png',
              height: 50,
              width: 50,
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.credit_card_rounded,
              size: 20,
            ),
            label: "Cards",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 20,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
