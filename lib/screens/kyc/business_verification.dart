// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/profile/next_of_kin.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/service/cloudinary/cloudinary.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class BusinessVerification extends StatefulWidget {
  const BusinessVerification({
    super.key,
  });

  @override
  State<BusinessVerification> createState() => _BusinessVerificationState();
}

class _BusinessVerificationState extends State<BusinessVerification> {
  final _companyController = Get.find<CompanyController>();

  bool _toSelectImage = false;
  File? _selectedImage;
  String _uploadedImageUrl = '';
  final ImagePicker _picker = ImagePicker();

  String? selectedCompanyType;
  final List<String> items = [
    'RC',
    'BN',
    'IT',
    'LL',
    'LLP',
  ];

  @override
  void dispose() {
    _companyController.companyNameController.clear();
    _companyController.rcNumberController.clear();
    super.dispose();
  }

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
                    pageName: "Business Verification",
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
                              'CAC Documents',
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
                              'Please provide us information about issued certificate from the corporate affairs commission to certify that your business is registered.',
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
                            const AutoSizeText(
                              'Tell us your Business Name',
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
                              controller:
                                  _companyController.companyNameController,
                              title: 'Enter Company Name',
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
                              'Select Company Type',
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
                                  borderRadius: BorderRadius.circular(0),
                                  border:
                                      Border.all(color: textBoxBorderColor)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Company Type',
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
                                  value: selectedCompanyType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCompanyType = value as String;
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
                              'Provide CAC Number',
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
                              controller: _companyController.rcNumberController,
                              title: 'Enter CAC Number',
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
                            const AutoSizeText(
                              'Please ensure that all document and bind into one pdf including the certificate, shares page and mermat.',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: stepsColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              width: Get.width,
                              height: 120,
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
                                          horizontal: Get.height * 0.05,
                                        ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_companyController.companyNameController.text != "" &&
                          selectedCompanyType != "" &&
                          _companyController.rcNumberController.text != "" &&
                          _uploadedImageUrl != "") {
                        await createCompany(context);
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
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createCompany(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _companyController.createCompany(
      _companyController.companyNameController.text,
      selectedCompanyType!,
      _companyController.rcNumberController.text,
      _uploadedImageUrl,
    );

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
}
