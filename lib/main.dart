import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'appbinding/appbinding.dart';
import 'screens/core/splash_speen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const FagoPay(),
  );
}

class FagoPay extends StatelessWidget {
  const FagoPay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
