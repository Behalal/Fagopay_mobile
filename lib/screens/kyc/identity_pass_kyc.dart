import 'package:fagopay/screens/kyc/countdown_page2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/user_controller.dart';

class IdentityPassPage extends StatefulWidget {
  const IdentityPassPage({
    super.key,
  });

  @override
  _IdentityPassPageState createState() => _IdentityPassPageState();
}

class _IdentityPassPageState extends State<IdentityPassPage> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> Function() requestPermissions = () async {
    await Permission.camera.request().isGranted;

    await Permission.microphone.request();
  };
  final _userUcontroller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    print('id is ${_userUcontroller.user!.id}');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: ElevatedButton(
          style: null,
          onPressed: () {
            FlutterIdentityKyc.showWidget(
              InputParameters(
                context: context,
                merchantKey: "tcusaxtpg2fscbixhdsz:IJd6cBRH3RCubl4iXGQZ0-bH-zI",
                firstName: 'domain',
                lastName: 'domain',
                email: 'domain@admin.com',
                userRef: _userUcontroller.user!.id,
                onCancel: (response) {
                  if (kDebugMode) {
                    print(response);
                  }
                },
                onVerified: (response) {
                  Get.to(() => const CountdownPage2());
                  if (kDebugMode) {
                    print(response);
                  }
                },
                onError: (error) => print(error),
              ),
            );
          },
          child: const Text('Verify My Identity'),
        ))));
  }
}
