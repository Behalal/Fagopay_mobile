import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProgressStyle extends StatelessWidget {
  Widget? backRoute;
  String pageName;
  int stage;
  double? width;
  String? icon;
  ProgressStyle({
    super.key,
    required this.pageName,
    this.backRoute,
    required this.stage,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: (icon != null)? MainAxisAlignment.spaceBetween: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (backRoute != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => backRoute!,
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Image(image: AssetImage("assets/images/Icon.png")),
            iconSize: 20,
          ),
          if ( icon == null )SizedBox(
            width: 8.w,
          ),
          Text(
            pageName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          Container()
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Container(
            height: (width != null) ? width : 2,
            width: (stage > 0) ? ((stage == 100) ? 90.w : 45.w) : 0,
            decoration: const BoxDecoration(
                color: fagoSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Container(
            height: 2,
            width: (stage > 0) ? ((stage == 50) ? 45.w : 0) : 90.w,
            decoration: const BoxDecoration(
                color: fagoSecondaryColorWithOpacity,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ],
      ),
    ]);
  }
}
