import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CountdownPage2 extends StatefulWidget {
  const CountdownPage2({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<CountdownPage2> createState() => _CountdownPage2State();
}

class _CountdownPage2State extends State<CountdownPage2> {
  final int _duration = 30;
  final CountDownController _controller = CountDownController();
  final userUcontroller = Get.find<UserController>();
  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AutoSizeText(
                "KYC Successful",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Hello ${userUcontroller.user!.firstName}! Congratulations ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w700,
                  color: fagoGreenColor,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              const Text(
                "You can now enjoy more services and we encourage you to upgrade to a higher Tier to access more of our product offers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: stepsColor,
                ),
              ),
              Center(
                child: CircularCountDownTimer(
                  // Countdown duration in Seconds.
                  duration: _duration,

                  // Countdown initial elapsed Duration in Seconds.
                  initialDuration: 0,

                  // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                  controller: _controller,

                  // Width of the Countdown Widget.
                  width: MediaQuery.of(context).size.width / 2,

                  // Height of the Countdown Widget.
                  height: MediaQuery.of(context).size.height / 2,

                  // Ring Color for Countdown Widget.
                  ringColor: signInPlaceholder.withOpacity(0.2),

                  // Ring Gradient for Countdown Widget.
                  ringGradient: null,

                  // Filling Color for Countdown Widget.
                  fillColor: fagoSecondaryColor,

                  // Filling Gradient for Countdown Widget.
                  fillGradient: null,

                  // Background Color for Countdown Widget.
                  backgroundColor: white,

                  // Background Gradient for Countdown Widget.
                  backgroundGradient: null,

                  // Border Thickness of the Countdown Ring.
                  strokeWidth: 20.0,

                  // Begin and end contours with a flat edge and no extension.
                  strokeCap: StrokeCap.round,

                  // Text Style for Countdown Text.
                  textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),

                  // Format for the Countdown Text.
                  textFormat: CountdownTextFormat.S,

                  // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                  isReverse: false,

                  // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                  isReverseAnimation: false,

                  // Handles visibility of the Countdown Text.
                  isTimerTextShown: true,

                  // Handles the timer start.
                  autoStart: true,

                  // This Callback will execute when the Countdown Starts.
                  onStart: () {
                    // Here, do whatever you want
                    debugPrint('Countdown Started');
                  },

                  // This Callback will execute when the Countdown Ends.
                  onComplete: () {
                    // Here, do whatever you want
                    _loginController.getUserDetails();
                    Get.offAll(() => const Dashboard());
                  },

                  // This Callback will execute when the Countdown Changes.
                  onChange: (String timeStamp) {
                    // Here, do whatever you want
                    debugPrint('Countdown Changed $timeStamp');
                  },

                  /* 
                    * Function to format the text.
                    * Allows you to format the current duration to any String.
                    * It also provides the default function in case you want to format specific moments
                      as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
                      the default behavior.
                  */
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      // only format for '0'
                      return "Start";
                    } else {
                      // other durations by it's default format
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                ),
              ),
              const Text(
                "Please wait while we setup your account and redirect you to the dashboard.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: stepsColor,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     const SizedBox(
      //       width: 30,
      //     ),
      //     _button(
      //       title: "Start",
      //       onPressed: () => _controller.start(),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     _button(
      //       title: "Pause",
      //       onPressed: () => _controller.pause(),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     _button(
      //       title: "Resume",
      //       onPressed: () => _controller.resume(),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     _button(
      //       title: "Restart",
      //       onPressed: () => _controller.restart(duration: _duration),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
