// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class FagoMainPage extends StatefulWidget {
  const FagoMainPage({
    super.key,
  });

  @override
  State<FagoMainPage> createState() => _FagoMainPageState();
}

class _FagoMainPageState extends State<FagoMainPage> {
  bool isIndividual = false;
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Fago',
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
              // ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        'Coming Soon !!',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: stepsColor,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
