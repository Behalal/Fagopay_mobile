// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final String paymentLink;

//   const PaymentScreen({
//     Key? key,
//     required this.paymentLink,
//   }) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late WebViewController controller;

//   @override
//   void initState() {
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {
//             print('hiua');
//           },
//           onPageFinished: (String url) {
//             print('hi');
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.paymentLink));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     controller.addJavaScriptChannel(
//       'Print',
//       onMessageReceived: (JavaScriptMessage message) {
//         print(message.message);
//       },
//     );
//     return Scaffold(
//       body: SafeArea(
//         child: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
