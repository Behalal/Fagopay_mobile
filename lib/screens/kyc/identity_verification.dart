import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/government_identity_verification_controller.dart';
import 'package:fagopay/controllers/locations_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/kyc/components/number_input.dart';
import 'package:fagopay/screens/widgets/drop_down_field.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/cloudinary/cloudinary.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import '../../../models/locations_model.dart' as location;
import 'package:dio/dio.dart';
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


  Future<void> verifyGovernmentIdentity({required String countryID, required String documentType, required String documentNumber}) async {
    progressIndicator(context);
    try {

      final body = jsonEncode({
        "country_id": countryID,
        "document_type": documentType,
        "document_number": documentNumber
      });
      final response = await NetworkProvider().call(path: "/v1/verify/government-identity", method: RequestMethod.post, body: body);
      if(response?.statusCode == 200 || response?.statusCode == 201){
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Success", response?.data["data"]["message"] ?? "Verification was successful");
      }
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (error) {
      Get.back();
      Get.snackbar('Error', error.toString());
      throw error.toString();
    }
  }


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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w),
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
                    physics: const BouncingScrollPhysics(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              'Select Country',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: welcomeText,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            DropDownTextField(
                              onChanged: (value) {
                                setState(() {
                                  selectedCountry = value as String;
                                });
                              },
                              items: countries.map((item) => DropdownMenuItem<String>(
                                value: item.id,
                                child: Text("${item.name}",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                              )).toList(),
                              title: "Select Countries",
                            ),
                          ],
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
                        SizedBox(
                          height: 1.h,
                        ),
                        DropDownTextField(
                          onChanged: (value) {
                            setState(() {
                              selectedDocumentType = value as String;
                            });
                          },
                          items: items.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                          )).toList(),
                          title: "Select Document",
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
                          height: 1.h,
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
                          height: 1.h,
                        ),
                        Container(
                          width: Get.width,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: fagoSecondaryColor, width: 0.7)),
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
                                  color: fagoSecondaryColor, width: 0.7)),
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
                                selectedDocumentType != null && _governmentIdentityController
                                    .documentNumberController.text != "" && _uploadedImageUrl != ""
                            ) {
                              await verifyGovernmentIdentity(
                                  countryID: selectedCountry,
                                  documentType: selectedDocumentType!,
                                  documentNumber: _governmentIdentityController.documentNumberController.text
                              );
                              return;
                            }
                            Get.snackbar("Error","Fill the form properly!");
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
    );
  }

  Future<void> submitGovernmentIdentityDetails(BuildContext context) async {
    progressIndicator(context);
    final response = await _governmentIdentityController.submitIdentityDetails(
        selectedCountry,
        selectedDocumentType!,
        _governmentIdentityController.documentNumberController.text,
        _uploadedImageUrl,);

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (!mounted) return;
      Navigator.of(context).pop();
      Get.snackbar("Success","Submitted Successfully");
      return;
    }
    Get.back();
    Get.snackbar("Error","${jsonBody['data']['error']}");
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
        Get.snackbar("Error","Failed to select Image!, Try Again..");
      }
    } on PlatformException {
      Get.snackbar("Error","Failed to select Image!, Try Again..");
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
