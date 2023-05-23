import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
//import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  final userUcontroller = Get.find<UserController>();
  bool _isRunning = true;
  // final _controller = CountDownController();
  final _controller2 = CountDownController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //   height: 200,
                //   width: 200,
                //   child: CountDownProgressIndicator(
                //       // controller: _controller,
                //       valueColor: fagoSecondaryColor,
                //       backgroundColor: signInPlaceholder,
                //       initialPosition: 0,
                //       duration: 10,
                //       // timeFormatter: (seconds) {
                //       //   return Duration(seconds: seconds)
                //       //       .toString()
                //       //       .split('.')[0]
                //       //       .padLeft(3, '0');
                //       // },
                //       text: 'Secs',
                //       onComplete: () {
                //         setState(() {
                //           if (_isRunning) {
                //             print('yes');
                //           } else {
                //             print('no');
                //           }
                //         });
                //       }),
                // ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   height: 200,
                //   width: 200,
                //   child: CountDownProgressIndicator(
                //     controller: _controller2,
                //     valueColor: fagoSecondaryColor,
                //     backgroundColor: signInPlaceholder,
                //     initialPosition: 0,
                //     duration: 365,
                //     text: 'Seg',
                //     onComplete: () => null,
                //   ),
                // ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () => setState(() {
                //     print('yes');
                //     if (_isRunning) {
                //       //  _controller.pause();
                //       // _controller2.pause();
                //     } else {
                //       //  _controller.resume();
                //       // _controller2.resume();
                //     }

                //     _isRunning = !_isRunning;
                //   }),
                //   child: Text(_isRunning ? 'Pause' : 'Resume'),
                // ),
                CircularCountDownTimer(
                  duration: 10,
                  initialDuration: 0,
                  controller: _controller2,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  ringColor: Colors.grey[300]!,
                  ringGradient: null,
                  fillColor: Colors.purpleAccent[100]!,
                  fillGradient: null,
                  backgroundColor: Colors.purple[500],
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: false,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    debugPrint('Countdown Started');
                  },
                  onComplete: () {
                    debugPrint('Countdown Ended');
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "Start";
                    } else {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
