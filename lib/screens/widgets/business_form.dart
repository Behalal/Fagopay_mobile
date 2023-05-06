import 'package:auto_size_text/auto_size_text.dart';
import '../../controllers/customers_controller.dart';
import '../../controllers/locations_controller.dart';
import 'custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../models/locations_model.dart' as location;

import '../constants/colors.dart';

class BusinessForm extends StatefulWidget {
  const BusinessForm({
    Key? key,
  }) : super(key: key);

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _locationsController = Get.find<LocationsController>();
  final _customerController = Get.find<CustomerController>();
  List<location.Country> countries = [];
  List<location.State> states = [];
  List<location.City> cities = [];

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          "Fullname",
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
            controller: _customerController.nameController,
            keyboardType: TextInputType.name,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: stepsColor),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: linearGradient1,
                      width: 1.0,
                      style: BorderStyle.solid)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
            controller: _customerController.phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: stepsColor),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: linearGradient1,
                      width: 1.0,
                      style: BorderStyle.solid)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "Enter phonenumber",
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
            controller: _customerController.emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: stepsColor),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: linearGradient1,
                      width: 1.0,
                      style: BorderStyle.solid)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 35.w,
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
                          _customerController.countryController.text = p0;
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
              width: 50.w,
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
                          _customerController.stateController.text = p0;
                          cities = [];
                        });
                        await getCities(p0);
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
                      _customerController.cityController.text = p0;
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
            controller: _customerController.addressController,
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: stepsColor),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: textBoxBorderColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: linearGradient1,
                      width: 1.0,
                      style: BorderStyle.solid)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: textBoxBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid)),
              hintText: "12, adjascent KFC, Ikoyi estate, island",
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
    );
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
}
