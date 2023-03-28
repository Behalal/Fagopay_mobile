import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'screens/core/app_widget.dart';

enum AppFlavor {
  dev,
  staging,
  prod,
}

Future<void> boostrap(AppFlavor env) async {
  // final prefs = await SharedPreferences.getInstance();
  // final showLogin = prefs.getBool('showLogin') ?? false;
  runApp(
    ProviderScope(
      child: Sizer(
        builder: ((context, orientation, deviceType) {
          return const AppWidget(
              // showLogin: showLogin
              );
        }),
      ),
    ),
  );
}
