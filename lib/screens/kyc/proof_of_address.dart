// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/controllers/government_identity_verification_controller.dart';
import 'package:fagopay/controllers/locations_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/widgets/custom_dropdown_field.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/cloudinary/cloudinary.dart';
import '../../../models/locations_model.dart' as location;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class ProofOfAddress extends StatefulWidget {
  const ProofOfAddress({
    super.key,
  });

  @override
  State<ProofOfAddress> createState() => _ProofOfAddressState();
}

class _ProofOfAddressState extends State<ProofOfAddress> {
  final _locationsController = Get.find<LocationsController>();
  final _identityVerificationController =
      Get.find<GovernmentIdentityVerificationController>();

  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";
  List<location.Country> countries = [];
  List<location.State> states = [];
  List<location.City> cities = [];

  bool _toSelectImage = false;
  File? _selectedImage;
  String _uploadedImageUrl = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    _identityVerificationController.businessAddressController.clear();
    super.dispose();
  }

  String? selectedBillType;
  final List<String> items = [
    'bank_statement',
    'rent_receipt',
    'waste_bill',
    'eletricity_bill',
    'cable_bill',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        child: Column(
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "Proof of Address",
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        'Upload Utility Bill',
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
                        'Please upload a document that shows your current business address. We accept bank statement, rent receipt, waste bill, water bill, electricity bill, or Cable Bill.',
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
                      Divider(
                        color: stepsColor.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const AutoSizeText(
                        'Tell us your current Business Address',
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
                      NameTextfield(
                        controller: _identityVerificationController
                            .businessAddressController,
                        title: '12, adjascent KFC, Ikoyi estate, island',
                        keyboadType: TextInputType.text,
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
                        "Country",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: welcomeText,
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
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
                              states = [];
                            });
                            await getStates(p0);
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  'State',
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
                                CustomDropdownButton(
                                  hint: 'Select State',
                                  items: states
                                      .map(
                                        (state) => DropdownMenuItem(
                                      value: state.id,
                                      child: FittedBox(
                                        child: AutoSizeText(
                                          '${state.name}',
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (p0) async {
                                    if (p0 != null) {
                                      setState(() {
                                        selectedState = p0;
                                        cities = [];
                                      });
                                      await getCities(p0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  'City',
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
                                CustomDropdownButton(
                                  hint: 'Select City',
                                  items: cities
                                      .map(
                                        (city) => DropdownMenuItem(
                                      value: city.id,
                                      child: FittedBox(
                                        child: AutoSizeText(
                                          '${city.name}',
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (p0) {
                                    if (p0 != null) {
                                      setState(() {
                                        selectedCity = p0;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Divider(
                        color: stepsColor.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const AutoSizeText(
                        'Utility Bill Type',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                      Container(
                        width: Get.width,
                        height: 5.h,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(color: textBoxBorderColor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Bank Statement',
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
                            value: selectedBillType,
                            onChanged: (value) {
                              setState(() {
                                selectedBillType = value as String;
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
                        'Upload Document',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const AutoSizeText(
                        'Bank statement must show your name and address clearly',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: Get.width,
                        height: 101,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: stepsColor.withOpacity(0.3))),
                        child: _selectedImage != null
                            ? InkWell(
                          onTap: () {
                            _selectImageToUpload(context);
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
                                onTap: () {
                                  _selectImageToUpload(context);
                                },
                                child: _toSelectImage
                                    ? const CircularProgressIndicator
                                    .adaptive()
                                    : SvgPicture.asset(
                                  'assets/icons/upload_icon.svg',
                                  color: fagoSecondaryColor,
                                ),
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
                        height: 3.h,
                      ),
                      InkWell(
                        onTap: () async {
                          if (selectedCountry != "" &&
                              selectedState != "" &&
                              selectedCity != "" &&
                              _identityVerificationController
                                  .businessAddressController.text !=
                                  "" &&
                              _uploadedImageUrl != "") {
                            await submitProofOfAddress(context);
                            return;
                          }
                          Get.snackbar("Error","Fill the form properly!", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitProofOfAddress(BuildContext context) async {
  progressIndicator(context);
    final response = await _identityVerificationController.submitProofOfAddress(
      selectedBillType!,
      _uploadedImageUrl,
      _identityVerificationController.businessAddressController.text,
      selectedCity,
      selectedState,
    );

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.back();
      if (!mounted) return;
      Navigator.of(context).pop();
      Get.snackbar("Success","Supplier Created Successfully", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return;
    }
    Get.back();
    Get.snackbar("Error","${jsonBody['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
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

  Future<void> getStates(String countryId) async {
    final response = await _locationsController.getStates(countryId);
    List<location.State> returnedStates = response['data']
        .map<location.State>((state) => location.State.fromJson(state))
        .toList();
    setState(() {
      states.addAll(returnedStates);
    });
  }

  Future<void> getCities(String stateId) async {
    final response = await _locationsController.getCities(stateId);
    List<location.City> returnedCities = response['data']
        .map<location.City>((city) => location.City.fromJson(city))
        .toList();
    setState(() {
      cities.addAll(returnedCities);
    });
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
        Get.snackbar("Error","Failed to select Image!, Try Again..", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }
    } on PlatformException {
      Get.snackbar("Error","Failed to select Image!, Try Again..", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    }
  }
}
