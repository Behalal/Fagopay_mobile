import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Onboarding(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
          colors: [linearGradient1, linearGradient2],
        )),
        child: Center(
          child: SizedBox(
            width: 108,
            height: 146,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                    top: 0,
                    left: 6.93,
                    right: 0.04,
                    bottom: 90,
                    child: Image.asset("assets/images/Vector (1).png")),
                Positioned(
                    top: 21.28,
                    left: 0.1,
                    right: 12.71,
                    bottom: 0.07,
                    child: Image.asset("assets/images/Vector (2).png")),
                Positioned(
                  top: 41.29,
                  left: 23.71,
                  right: 24.56,
                  bottom: 3.16,
                  child: Image.asset("assets/images/Vector.png"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
