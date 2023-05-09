// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/data_model.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../transactions/confirm_transaction.dart';
import '../../widgets/data_dropdown.dart';
import 'airtime.dart';
import 'models/bill_post_model.dart';

class BuyData extends StatefulWidget {
  const BuyData({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  bool _mtnActive = false;
  bool _isLoading = false;
  bool _airtelActive = false;
  bool _gloActive = false;
  bool _etisatActive = false;
  final String _variationCode = "";
  List<DataDetails>? allData = [];
  List<DropdownMenuItem<String>> dataDropdown = [];
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact _contact = Contact(
    fullName: "",
  );
  final _billsController = Get.find<BillController>();

  @override
  void initState() {
    dataDropdown.add(
      const DropdownMenuItem(
          value: "", child: Text("Select a service Provider")),
    );
    super.initState();
  }

  @override
  void dispose() {
    _billsController.phoneController.clear();
    _billsController.amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: fagoBlackColor,
                size: 25,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Buy Airtime and Data',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 18,
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w700,
              ),
            ),
            bottom: const TabBar(
              indicatorColor: fagoSecondaryColor,
              indicatorWeight: 5,
              labelColor: fagoSecondaryColor,
              tabs: [
                Tab(
                  child: Text(
                    'Buy Data',
                    style: TextStyle(
                      color: fagoSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Work Sans',
                    ),
                  ),
                ),
                Tab(
                  child: Text('Buy Airtime'),
                ),
              ],
            ),
          ),
          body: Builder(builder: (context) {
            return TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Select Network Provider",
                          style: TextStyle(
                              color: welcomeText,
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  // final progress1 = ProgressHUD.of(context);
                                  _isLoading = true;
                                  _mtnActive = true;
                                  _airtelActive = false;
                                  _gloActive = false;
                                  _etisatActive = false;
                                  buyDataFields.setServiceid = "mtn-data";
                                  // if (isLoading) {
                                  //   progress1!.show();
                                  // }

                                  // progress1!.dismiss();
                                });
                                await fetchDataByServiceId(
                                    buyDataFields.serviceid, context);
                              },
                              child: Container(
                                width: 20.w,
                                decoration: BoxDecoration(
                                    border: (_mtnActive)
                                        ? Border.all(
                                            color: fagoSecondaryColor,
                                            width: 2.0)
                                        : null,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/images/mtn.png")),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                  _mtnActive = false;
                                  _airtelActive = true;
                                  _gloActive = false;
                                  _etisatActive = false;
                                  buyDataFields.setServiceid = "airtel-data";
                                });
                                await fetchDataByServiceId(
                                    buyDataFields.serviceid, context);
                              },
                              child: Container(
                                width: 20.w,
                                decoration: BoxDecoration(
                                    border: (_airtelActive)
                                        ? Border.all(
                                            color: fagoBlue, width: 2.0)
                                        : null,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/airtel.png")),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                  _mtnActive = false;
                                  _airtelActive = false;
                                  _gloActive = true;
                                  _etisatActive = false;
                                  buyDataFields.setServiceid = "glo-data";
                                });
                                await fetchDataByServiceId(
                                    buyDataFields.serviceid, context);
                              },
                              child: Container(
                                width: 20.w,
                                decoration: BoxDecoration(
                                    border: (_gloActive)
                                        ? Border.all(
                                            color: fagoBlue, width: 2.0)
                                        : null,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/images/glo.png")),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                  _mtnActive = false;
                                  _airtelActive = false;
                                  _gloActive = false;
                                  _etisatActive = true;
                                  buyDataFields.setServiceid = "etisalat-data";
                                });
                                await fetchDataByServiceId(
                                    buyDataFields.serviceid, context);
                              },
                              child: Container(
                                width: 20.w,
                                decoration: BoxDecoration(
                                    border: (_etisatActive)
                                        ? Border.all(
                                            color: fagoBlue, width: 2.0)
                                        : null,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/etisalat.png")),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        // isLoading
                        //     ? const Center(
                        //         child: CircularProgressIndicator(
                        //           color: fagoSecondaryColor,
                        //         ),
                        //       )
                        //     :
                        DataDropDown(
                          model: buyDataFields,
                          dropDownItemsList: dataDropdown,
                          amount: _billsController.amountController,
                          code: _variationCode,
                          dataProvided: allData,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const AutoSizeText(
                          "Enter Phone Number",
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
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _billsController.phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: stepsColor),
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
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: textBoxBorderColor,
                                      width: 1.0,
                                      style: BorderStyle.solid)),
                              hintText: "Enter Phone Number",
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
                          height: 0.5.h,
                        ),
                        Container(
                          width: 90.w,
                          decoration: const BoxDecoration(
                              color: fagoSecondaryColorWithOpacity10,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        "assets/images/account.png")),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  _contact.fullName!,
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: welcomeText,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                GestureDetector(
                                  onTap: (() async {
                                    Contact? contact =
                                        await _contactPicker.selectContact();
                                    setState(() {
                                      _contact = contact!;
                                      _billsController.phoneController.text =
                                          _contact.phoneNumbers![0];
                                    });
                                  }),
                                  child: const AutoSizeText(
                                    "Select from Contacts",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: fagoBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Text(
                        //   _contact==null
                        //       ? 'No contact selected.'
                        //       : _contact.toString(),
                        // ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const AutoSizeText(
                          "Amount",
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
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _billsController.amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: stepsColor,
                            ),
                            decoration: InputDecoration(
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
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              hintText: "Enter Amount",
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
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: GestureDetector(
                            onTap: (() {
                              if (_billsController
                                      .phoneController.text.isEmpty ||
                                  buyDataFields.serviceid.isEmpty ||
                                  _billsController
                                      .amountController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Kindly enter all fields",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text('Kindly enter all fields'),
                                //   ),
                                // );
                              } else {
                                setState(() {
                                  buyDataFields.setPhone = _billsController
                                      .phoneController.text
                                      .replaceAll(' ', '');
                                  buyDataFields.setBillersCode =
                                      _billsController.phoneController.text;
                                  buyDataFields.setAmount =
                                      _billsController.amountController.text;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ConfirmTransactions(
                                      backRoute: const BuyData(),
                                      action: "buy_data",
                                    ),
                                  ),
                                );
                              }
                            }),
                            child: AuthButtons(
                              form: true,
                              text: "Continue",
                              route: ConfirmTransactions(
                                backRoute: const BuyData(),
                                action: "buy_data",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const BuyAirtime(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> fetchDataByServiceId(
      String serviceId, BuildContext context) async {
    final response = await _billsController.getDatabyServiceId(serviceId);
    List<DataDetails> x = response['data']['variation']
        .map<DataDetails>((variation) => DataDetails.fromJson(variation))
        .toList();
    allData = x;
    dataDropdown = getBankList(allData!);
    setState(() {
      _isLoading = false;
    });
  }

  List<DropdownMenuItem<String>> getBankList(List<DataDetails> data) {
    List<DropdownMenuItem<String>> dataItems = [];
    dataItems.add(
      const DropdownMenuItem(value: "", child: Text("Select Desired Data")),
    );

    for (var i = 0; i < data.length; i++) {
      dataItems.add(
        DropdownMenuItem(value: i.toString(), child: Text(data[i].name)),
      );
    }

    return dataItems;
  }
}
