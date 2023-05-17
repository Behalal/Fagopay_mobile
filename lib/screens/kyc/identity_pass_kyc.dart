import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';

import 'kyc_success.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';
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
                firstName: _userUcontroller.user!.firstName,
                lastName: _userUcontroller.user!.lastName,
                email: _userUcontroller.user!.email ?? '',
                userRef: _userUcontroller.user!.id,
                onCancel: (response) {
                  if (kDebugMode) {
                    print(response);
                  }
                },
                onVerified: (response) {
                  Get.to(() => const kyc_success());
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
