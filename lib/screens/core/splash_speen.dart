import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:sizer/sizer.dart';

import '../../service/secure_storage/secure_storage.dart';
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
      const Duration(seconds: 5), () async{
        final token =  await SecureStorage.readUserToken();
        print('this is user token $token');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => const Onboarding(),
          ),
        );
      }
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
          child: SvgPicture.asset("assets/images/FagoLogo.svg"),
        ),
      ),
    );
  }
}
