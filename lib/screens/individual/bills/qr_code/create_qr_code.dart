import 'package:flutter/material.dart';

import '../../../widgets/head_style_extra_pages.dart';
class CreateQrCode extends StatefulWidget {
  const CreateQrCode({Key? key}) : super(key: key);

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProgressStyle(
              stage: 0,
              width: double.infinity,
              pageName: "My Qr Code",
              // backRoute: MakeRequest(),
            ),
          ],
        ),
      ),
    );
  }
}
