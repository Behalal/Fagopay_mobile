import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FundWalletWebView extends StatefulWidget {
  final String url;
  const FundWalletWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<FundWalletWebView> createState() => _FundWalletWebViewState();
}

class _FundWalletWebViewState extends State<FundWalletWebView> {
  WebViewController? controller;
  @override
  Widget build(BuildContext context) {
    //print('url = ${widget.url}');
      controller = WebViewController()
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onUrlChange: (url){
              print('url changed = $url');
            },
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              print('navigation url = ${request.url}');
              if (request.url.contains('status=cancelled')) {
                Get.snackbar('Canceled','Transactions Canceled',colorText: white,backgroundColor: fagoSecondaryColor);
              //  return NavigationDecision.prevent;
                Navigator.pop(context);
              }else if(request.url.contains('status=completed')){
                Get.snackbar('Success','Transactions Successful',colorText: white,backgroundColor: fagoGreenColor);
                Navigator.pop(context);
              }
              return NavigationDecision.navigate;
            },
          ),
        )..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: fagoBlackColor),
        title: Text('Fund Wallet',style: Constant().textStyle(size: 18, weight: FontWeight.w900)),
        backgroundColor: white,
        elevation: 0,
      ),
      body:  SafeArea(child: WebViewWidget(controller: controller!,)),
    );
  }
}
//https://checkout.flutterwave.com/v3/hosted/pay/flwlnk-01h2dg9ady7vmpyxabt2bgq31a