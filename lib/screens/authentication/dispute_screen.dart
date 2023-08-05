import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/drop_down_field.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/service/cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';


class DisputeScreen extends StatefulWidget {
  const DisputeScreen({super.key});

  @override
  State<DisputeScreen> createState() => _DisputeScreenState();
}

class _DisputeScreenState extends State<DisputeScreen> {
  final _controller = Get.find<LoginController>();
  final reasonIdController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final referenceCode = TextEditingController();

  @override
  void initState() {
    _controller.getDisputeReason();
    super.initState();
  }

  bool _toSelectImage = false;
  File? _selectedImage;
  String _uploadedImageUrl = '';
  final ImagePicker _picker = ImagePicker();

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

  Widget _businessDescriptionForm(){
    var maxLine = 8;
    return Container(height: maxLine * 18.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        validator: (value){
          List<String> words = value!.trim().split(' ');
          words = words.where((word) => word.isNotEmpty).toList();
          if (words.length < 15) {
            return 'Please enter at least 15 words';
          }
          return null;
        },
        controller: descriptionController, textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: null,  // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
        expands: true,
        // maxLines: 11,
        decoration: InputDecoration(
          counterText: " ",
          hintText: "Describe your business and provide other details",
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff868484), fontSize: 14),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: fagoSecondaryColor, width: 0.7)),
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            body: controller.disputeReasonResponse == null && controller.onGetDisputeReasonLoadingState == true && controller.onGetDisputeResponseErrorState == false ?
            const Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 30,),
                  Text("Please wait"),
                ],
              ),
            ) : controller.disputeReasonResponse != null && controller.onGetDisputeReasonLoadingState == false && controller.onGetDisputeResponseErrorState == false ?
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w),
              child: Column(
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Submit Dispute",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText('Open a Transaction Dispute',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                              const AutoSizeText('Please share information about your challenge.',
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
                                    'Select a dispute reason',
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
                                      reasonIdController.text = value.toString();
                                    },
                                    items: controller.disputeReasonResponse?.data?.disputeReason?.map((item) => DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.description ?? "",
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                                    )).toList(),
                                    title: "Bills Payment",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Enter email',
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
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400, fontSize: 15,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: fagoSecondaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: fagoSecondaryColor,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: fagoSecondaryColor,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    hintText: "Email",
                                    hintStyle: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: stepsColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Do you have a reference code?',
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
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  controller: referenceCode,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: fagoSecondaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: fagoSecondaryColor,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: fagoSecondaryColor,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    hintText: "Enter reference code",
                                    hintStyle: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: stepsColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AutoSizeText(
                                'Please specify your challenges.',
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
                              _businessDescriptionForm(),
                              const AutoSizeText(
                                'Please upload an evidence',
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
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: fagoSecondaryColor, width: 0.7)),
                                child: _selectedImage != null
                                    ? InkWell(
                                  onTap: () async {
                                    log("message");
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async{
                                          await _selectImageToUpload(context);
                                        },
                                        child: _toSelectImage
                                            ? const CircularProgressIndicator
                                            .adaptive()
                                            : SvgPicture.asset(
                                          'assets/icons/upload_icon.svg', color: fagoSecondaryColor,),
                                      ),
                                      SizedBox(height: 1.h,),
                                      const AutoSizeText(
                                        'Tap to upload. PNG, JPG, PDF is accepted',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
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
                                  if (reasonIdController.text != "" &&
                                      emailController.text !=  "" && descriptionController.text != "" && _uploadedImageUrl != ""
                                  ){
                                    controller.createDispute(reasonId: reasonIdController.text, email: emailController.text, referenceCode: referenceCode.text,
                                        description: descriptionController.text, documentUrl: _uploadedImageUrl, context: context);
                                  }else{
                                    Get.snackbar("Error","Fill the form properly!", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                  }

                                },
                                child: Center(
                                  child: AuthButtons(
                                    text: "Continue",
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
            ) : const Center(
              child: Column(
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 30,),
                  Text("Please wait"),
                ],
              ),
            ),
          ));
    });
  }
}
