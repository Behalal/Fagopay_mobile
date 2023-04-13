import 'package:fagopay/screens/kyc/kyc_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class IdentityPassPage extends StatefulWidget {
  const IdentityPassPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: ElevatedButton(
          style: null,
          onPressed: () {
            FlutterIdentityKyc.showWidget(InputParameters(
                context: context,
                merchantKey: "tcusaxtpg2fscbixhdsz:IJd6cBRH3RCubl4iXGQZ0-bH-zI",
                firstName: "Kehinde",
                lastName: "Obe",
                email: "kennyobey@gmail.com",
                userRef: "10",
                onCancel: (response) {
                  print(response);
                },
                onVerified: (response) {
                  Get.to(() => const kyc_success());
                },
                onError: (error) => print(error)));
          },
          child: const Text('Verify My Identity'),
        ))));
  }
}
