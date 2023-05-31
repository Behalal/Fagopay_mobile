// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/government_identity_verification_controller.dart';
import 'package:fagopay/controllers/locations_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/kyc/components/number_input.dart';
import 'package:fagopay/service/cloudinary/cloudinary.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../models/locations_model.dart' as location;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/screens/widgets/custom_dropdown_field.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
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
  final _locationsController = Get.find<LocationsController>();
  final _governmentIdentityController = Get.find<GovernmentIdentityVerificationController>();
  List<location.Country> countries = [];

  String selectedCountry = "";

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    _governmentIdentityController.documentNumberController.clear();
    super.dispose();
  }

  bool _toSelectImage = false;
  File? _selectedImage;
  String _uploadedImageUrl = '';
  final ImagePicker _picker = ImagePicker();

  String? selectedDocumentType;
  final List<String> items = [
    'Driver_License',
    'NIN',
    'International_Passport'
  ];

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
              child: Column(
                children: [
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
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: SingleChildScrollView(
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
                                'Please provide us information about issued government ID as required by Authorities.',
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

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDropdownButton(
                                      hint: 'Select Country',
                                      items: countries
                                          .map(
                                            (country) => DropdownMenuItem(
                                              value: country.id,
                                              child: Text(
                                                '${country.name}',
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (p0) async {
                                        if (p0 != null) {
                                          setState(() {
                                            selectedCountry = p0;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Select Document to Upload',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
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
                                    value: selectedDocumentType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDocumentType = value as String;
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
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                "Enter ID Number",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              NumberInput(
                                controller: _governmentIdentityController.documentNumberController,
                                title: "Enter ID Number",
                                keyboadType: TextInputType.number,
                                boarderColor: stepsColor.withOpacity(0.3),
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Upload ID Document',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Container(
                                width: Get.width,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: stepsColor.withOpacity(0.3))),
                                child: _selectedImage != null
                                    ? InkWell(
                                        onTap: () async {
                                          await _selectImageToUpload(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.05,
                                              horizontal: Get.height * 0.05),
                                          height: Get.height * 0.4,
                                          width: Get.height * 0.4,
                                          decoration: BoxDecoration(
                                              color: fagoSecondaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                              image: DecorationImage(
                                                image: FileImage(
                                                  _selectedImage!,
                                                ),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                            InkWell(
                                              onTap: () async {
                                                await _selectImageToUpload(
                                                    context);
                                              },
                                              child: _toSelectImage
                                                  ? const CircularProgressIndicator
                                                      .adaptive()
                                                  : SvgPicture.asset(
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
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                width: Get.width,
                                //height: ,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: stepsColor.withOpacity(0.3))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                     Row(
                                      children: const [
                                        AutoSizeText(
                                          'See Example Image',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: fagoSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                              'assets/images/sample document.png'),
                                        ),
                                        const Expanded(
                                          child: AutoSizeText(
                                            'You can find the ID Number circled with red line on the example image.',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: stepsColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (selectedCountry != "" &&
                                      selectedDocumentType != null &&
                                      _governmentIdentityController
                                              .documentNumberController.text !=
                                          "" &&
                                      _uploadedImageUrl != "") {
                                    await submitGovernmentIdentityDetails(
                                        context);
                                    return;
                                  }
                                  Fluttertoast.showToast(
                                    msg: "Fill the form properly!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                                child: Center(
                                  child: AuthButtons(
                                    text: "Submit",
                                    form: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitGovernmentIdentityDetails(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _governmentIdentityController.submitIdentityDetails(
        selectedCountry,
        selectedDocumentType!,
        _governmentIdentityController.documentNumberController.text,
        _uploadedImageUrl,);

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      progress.dismiss();
      if (!mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Submitted Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    progress.dismiss();
    Fluttertoast.showToast(
      msg: "${jsonBody['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _selectImageToUpload(BuildContext context) async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      if (pickedImage == null) return;
      setState(() {
        _toSelectImage = true;
      });
      final imageTemp = File(pickedImage.path);
      if (!mounted) return;
      _uploadedImageUrl = await Cloudinary.uploadUserImage(context, imageTemp);
      // print(_uploadedImageUrl);
      if (_uploadedImageUrl != '') {
        setState(() {
          _toSelectImage = false;
          _selectedImage = imageTemp;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Failed to select Image!, Try Again..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on PlatformException {
      Fluttertoast.showToast(
        msg: "Failed to select Image!, Try Again..",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getCountries() async {
    final response = await _locationsController.getCountries();
    List<location.Country> returnedCountries = response['data']
        .map<location.Country>((country) => location.Country.fromJson(country))
        .toList();
    setState(() {
      countries = returnedCountries;
    });
  }
}
