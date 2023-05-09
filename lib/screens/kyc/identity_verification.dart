// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class IdentificationVerification extends StatefulWidget {
  const IdentificationVerification({
    super.key,
  });

  @override
  State<IdentificationVerification> createState() =>
      _IdentificationVerificationState();
}

class _IdentificationVerificationState
    extends State<IdentificationVerification> {
  File? image;
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        print('images path is: ${image.path}');
      });

      // {
      //   image.add(File(pickedImages.pa isth));
      //   if (kDebugMode) {
      //     print('images: ${image.length}');
      //   }
      // }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  String? selectedAcount;
  final List<String> items = [
    'Driver Licence',
    'NIN',
    'International Passport',
  ];

  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(children: [
              const ProgressStyle(
                stage: 0,
                pageName: "Identity Verification",
                // backRoute: MakeRequest(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          'Provide Government ID',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: fagoSecondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const AutoSizeText(
                          'Enjoy more access to our services when you verify your identity.',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: stepsColor,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        const AutoSizeText(
                          'Enjoy more access to our services when you verify your identity.',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: stepsColor,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.02,
                              horizontal: Get.height * 0.02),
                          // height: Get.height * 0.10,
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: stepsColor.withOpacity(0.2)),
                              color: white,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AutoSizeText(
                                'Country of Residence',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: Get.width,
                          height: 48,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: stepsColor.withOpacity(0.2))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Document',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedAcount,
                              onChanged: (value) {
                                setState(() {
                                  selectedAcount = value as String;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width,
                          height: 101,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: stepsColor.withOpacity(0.3))),
                          child: image != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.05,
                                      horizontal: Get.height * 0.05),
                                  height: Get.height * 0.4,
                                  width: Get.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: fagoSecondaryColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      image: DecorationImage(
                                        image: FileImage(
                                          image!,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                      InkWell(
                                        onTap: () {
                                          pickImageFromGallery();
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/upload_icon.svg'),
                                      ),
                                      const AutoSizeText(
                                        'Tap to upload. PNG, JPG, PDF is accepted',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: stepsColor,
                                        ),
                                      ),
                                      const AutoSizeText(
                                        'File size should not exceed 1mb.',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: stepsColor,
                                        ),
                                      ),
                                    ]),
                        )
                      ],
                    )),
              ),
            ])));
  }
}
