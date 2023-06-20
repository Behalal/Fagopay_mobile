import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../../../controllers/locations_controller.dart';
import '../../../controllers/suppliers_controller.dart';
import '../../../controllers/transaction_controller.dart';
import '../../../models/bank_model.dart';
import '../../../models/locations_model.dart' as location;
import '../../widgets/banks_dropdown.dart';
import '../../widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';

class AddSupplies extends StatefulWidget {
  const AddSupplies({super.key});

  @override
  State<AddSupplies> createState() => _AddSuppliesState();
}

class _AddSuppliesState extends State<AddSupplies> {
  List<BankDetails> allBanks = [];
  final _transactionController = Get.find<TransactionController>();
  final _locationsController = Get.find<LocationsController>();
  final _supplierController = Get.find<SupplierController>();
  String selectedBankValue = "";
  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";
  List<location.Country> countries = [];
  List<location.State> states = [];
  List<location.City> cities = [];

  @override
  void initState() {
    callBankProvider();
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    _supplierController.accountNumberController.clear();
    _supplierController.emailController.clear();
    _supplierController.addressController.clear();
    _supplierController.phoneNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      init: TransactionController(),
        builder: (controller){
      return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressStyle(
                  stage: 0,
                  width: 4,
                  pageName: "Add Supplier",
                ),
                SizedBox(
                  height: 4.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: SelectBank(
                        bankdropdown: getBankList(allBanks),
                        onChanged: (selectedValue) {
                          setState(() {
                            selectedBankValue = selectedValue!;
                          });
                        },
                        selectedValue: "",
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Supplier Account Number",
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
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        controller:
                        _supplierController.accountNumberController,
                        onChanged: (value) async {
                          if (value.length == 10) {
                            await _transactionController.getBankDetails(selectedBankValue, value);
                          }else if(value.isEmpty || value == ""){
                            setState(() {
                              controller.getBankDetailsLoadingState = null;
                            });
                          }else if (value.length <= 9){
                            setState(() {
                              _transactionController.verifiedReceipientUser = "No user found";
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: controller.getBankDetailsLoadingState == true && controller.getBankDetailsErrorState == false ?
                          const CupertinoActivityIndicator(color: fagoSecondaryColor,) : const SizedBox(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: linearGradient1,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: "Enter Account Number",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Supplier Account Name",
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
                    controller.getBankDetailsLoadingState == null || controller.getBankDetailsLoadingState == true ? const SizedBox() :
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      decoration: const BoxDecoration(
                        color: fagoSecondaryColorWithOpacity10,
                      ),
                      child: AutoSizeText(
                        controller.verifiedReceipientUser ?? "",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: inactiveTab,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Email",
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
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        controller: _supplierController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: linearGradient1,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: "Enter email",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Phone Number",
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
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        controller:
                        _supplierController.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: linearGradient1,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText: "Enter fullname",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 42.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 42.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                "State",
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "City",
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
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Address",
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
                    SizedBox(
                      width: 90.w,
                      child: TextFormField(
                        controller: _supplierController.addressController,
                        keyboardType: TextInputType.streetAddress,
                        style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: linearGradient1,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: textBoxBorderColor,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          hintText:
                          "12, adjascent KFC, Ikoyi estate, island",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                GetBuilder<TransactionController>(
                    init: TransactionController(),
                    builder: (controller){
                      return GestureDetector(
                        onTap: () async {
                          if(_supplierController.accountNumberController.text.isEmpty
                              || selectedBankValue == "" || controller.verifiedReceipientUser == null
                              || _supplierController.phoneNumberController.text.isEmpty
                              || _supplierController.emailController.text.isEmpty
                              || _supplierController.addressController.text.isEmpty
                              || selectedCountry == ""
                              || selectedState == "" || selectedCity == ""){
                            Get.snackbar("Error", "Kindly fill the form correctly");
                          }else if(_supplierController.phoneNumberController.text.length < 11){
                            Get.snackbar("Error", "please provide a valid number");
                          }else {
                            await createSupplier(context, controller.verifiedReceipientUser);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child:
                          AuthButtons(form: true, text: "Save", route: null),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  void callBankProvider() async {
    final responseData = await _transactionController.getAllBanks();
    List<BankDetails> banks = responseData['data']
        .map<BankDetails>((bankDetail) => BankDetails.fromJson(bankDetail))
        .toList();
    setState(() {
      allBanks = banks;
    });
  }

  List<DropdownMenuItem<String>> getBankList(List<BankDetails> banks) {
    final allBanks = banks.map((bank) {
      return DropdownMenuItem(
        value: bank.bankCode,
        child: Text('${bank.bankName}'),
      );
    }).toList();

    List<DropdownMenuItem<String>> bankItems = [
      const DropdownMenuItem(value: "", child: Text("Select Bank")),
    ];
    bankItems.addAll(allBanks);
    return bankItems;
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

  Future<void> createSupplier(BuildContext context, String? accountName) async {
    progressIndicator(context);
    final response = await _supplierController.createNewSupplier(
      bankCode: selectedBankValue,
      accountNumber: _supplierController.accountNumberController.text,
      accountName: accountName ?? "",
      phone: _supplierController.phoneNumberController.text,
      email: _supplierController.emailController.text,
      address: _supplierController.addressController.text,
      countryId: selectedCountry,
      stateId: selectedState,
      cityId: selectedCity,
    );
    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (!mounted) return;
      setState(() {
        selectedBankValue = "";
        _supplierController.accountNumberController.clear();
        // accountName ?? "";
        _supplierController.phoneNumberController.clear();
        _supplierController.emailController.clear();
        _supplierController.addressController.clear();
        selectedCountry = "";
        selectedState = "";
        selectedCity = "";
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Get.snackbar("Success","Supplier Created Successfully");
      return;
    }else{
      setState(() {
        selectedBankValue = "";
        _supplierController.accountNumberController.clear();
        // accountName ?? "";
        _supplierController.phoneNumberController.clear();
        _supplierController.emailController.clear();
        _supplierController.addressController.clear();
        selectedCountry = "";
        selectedState = "";
        selectedCity = "";
      });
      Get.back();
      Get.snackbar("Error","${jsonBody['data']['error']}");
    }
  }
}
