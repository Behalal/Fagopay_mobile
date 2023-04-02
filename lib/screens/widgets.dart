import 'package:auto_size_text/auto_size_text.dart';
import 'authentication/widgets/auth_buttons.dart';
import 'constants/colors.dart';
import 'functions.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/loader.gif",
              width: 50,
              height: 50,
              fit: BoxFit.fitWidth,
            ),
          ]),
    );
  }
}

class PinCodeModal extends StatefulWidget {
  final String action;
  // final WidgetRef ref;
  const PinCodeModal({
    super.key,
    required this.action,
    // required this.ref,
  });

  @override
  State<PinCodeModal> createState() => _PinCodeModalState();
}

class _PinCodeModalState extends State<PinCodeModal> {
  final TextEditingController pincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 65.h,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.w,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Container(
                    width: 30.w,
                    decoration: BoxDecoration(
                        color: stepsColor,
                        border: Border.all(width: 1.5, color: stepsColor)),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SizedBox(
                    width: 80.w,
                    child: const AutoSizeText(
                      "input your transaction authentication code to confirm this transfer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: fagoPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: PinCodeTextField(
                    controller: pincontroller,
                    appContext: context,
                    obscureText: true,
                    length: 4,
                    onChanged: ((value) {
                      // if (value.length != 4 || value.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Kindly enter your pin'),
                      //     ),
                      //   );
                      // } else {
                      //   if (widget.action == "buy_airtime") {
                      //     setState(() {
                      //       buyAirtime(context, widget.ref, value);
                      //     });
                      //   } else if (widget.action == 'buy_data') {
                      //     setState(() {
                      //       buyData(context, widget.ref, value);
                      //     });
                      //   } else if (widget.action == 'buy_light') {
                      //     setState(() {
                      //       buyElectricity(context, widget.ref, value);
                      //     });
                      //   } else if (widget.action == 'buy_internet') {
                      //     setState(() {
                      //       buyInternet(context, widget.ref, value);
                      //     });
                      //   } else if (widget.action == 'tv') {
                      //     setState(() {
                      //       cableSubscription(context, widget.ref, value);
                      //     });
                      //   }
                      // }
                    }),
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: GestureDetector(
                      onTap: (() {
                        if (pincontroller.text.length != 4 ||
                            pincontroller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kindly enter your pin'),
                            ),
                          );
                        } else {
                          // if (widget.action == "buy_airtime") {
                          //   setState(() {
                          //     buyAirtime(
                          //         context, widget.ref, pincontroller.text);
                          //   });
                          // } else if (widget.action == 'buy_data') {
                          //   setState(() {
                          //     buyData(context, widget.ref, pincontroller.text);
                          //   });
                          // } else if (widget.action == 'buy_light') {
                          //   setState(() {
                          //     buyElectricity(
                          //         context, widget.ref, pincontroller.text);
                          //   });
                          // } else if (widget.action == 'buy_internet') {
                          //   setState(() {
                          //     buyInternet(
                          //         context, widget.ref, pincontroller.text);
                          //   });
                          // } else if (widget.action == 'tv') {
                          //   setState(() {
                          //     cableSubscription(
                          //         context, widget.ref, pincontroller.text);
                          //   });
                          // }
                        }
                      }),
                      child: AuthButtons(text: "Pay", form: true)),
                ),
                SizedBox(
                  height: 0.5.h,
                )
              ],
            ),
          ),
          NumericKeyboard(
            onKeyboardTap: ((text) {
              setState(() {
                pincontroller.text = pincontroller.text + text;
              });
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textColor: black,
            rightIcon: const Icon(
              Icons.backspace_outlined,
              size: 25,
            ),
            rightButtonFn: (() {
              setState(() {
                pincontroller.text = pincontroller.text
                    .substring(0, pincontroller.text.length - 1);
              });
            }),
          )
        ],
      ),
    );
  }
}

// show modal sheet

// Future showPinModal(BuildContext context, String action, WidgetRef ref) {
//   return showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       // shape: const ShapeBorder().add(),
//       context: context,
//       isScrollControlled: true,
//       isDismissible: true,
//       builder: (BuildContext context) {
//         //
//         return PinCodeModal(
//           action: action,
//           ref: ref,
//         ); //whatever you're returning, does not have to be a Container
//       });
// }
