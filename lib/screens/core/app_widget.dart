import 'package:fagopay/screens/core/splash_speen.dart';

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    // required this.showLogin,
    Key? key,
  }) : super(key: key);

  // final bool showLogin;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
