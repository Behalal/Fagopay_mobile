import 'package:auto_size_text/auto_size_text.dart';
import '../../../models/data_model.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'airtime.dart';
import 'models/bill_post_model.dart';
import '../transactions/confirm_transaction.dart';
import '../widgets/data_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:sizer/sizer.dart';

class BuyData extends StatefulWidget {
  const BuyData({super.key});

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  late bool mtnActive;
  late bool isLoading;
  late bool airtelActive;
  late bool gloActive;
  late bool etisatActive;
  late String variationCode;
  late List<DataDetails>? allData;
  late List<DropdownMenuItem<String>> dataDropdown;
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  late final Contact _contact;
  late TextEditingController phoneController;
  late TextEditingController amountController;

  @override
  void initState() {
    isLoading = false;
    mtnActive = false;
    airtelActive = false;
    gloActive = false;
    etisatActive = false;
    variationCode = "";
    allData = [];
    dataDropdown = [];
    _contact = Contact(
      fullName: "",
    );
    dataDropdown.add(
      const DropdownMenuItem(
          value: "", child: Text("Select a service Provider")),
    );
    amountController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneController.text =
        _contact == null ? 'No contact selected.' : _contact.toString();
    return DefaultTabController(
      length: 2,
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
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
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
                            onTap: () {
                              // setState(() {
                              //   // final progress1 = ProgressHUD.of(context);
                              //   isLoading = true;
                              //   mtnActive = true;
                              //   airtelActive = false;
                              //   gloActive = false;
                              //   etisatActive = false;
                              //   buyDataFields.setServiceid = "mtn-data";
                              //   // if (isLoading) {
                              //   //   progress1!.show();
                              //   // }
                              //   fetchDataByServiceId(
                              //       buyDataFields.serviceid, context);

                              //   // progress1!.dismiss();
                              // });
                            },
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (mtnActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image: AssetImage("assets/images/mtn.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   isLoading = true;
                              //   mtnActive = false;
                              //   airtelActive = true;
                              //   gloActive = false;
                              //   etisatActive = false;
                              //   buyDataFields.setServiceid = "airtel-data";
                              //   fetchDataByServiceId(
                              //       buyDataFields.serviceid, context);
                              // });
                            },
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (airtelActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image:
                                        AssetImage("assets/images/airtel.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   isLoading = true;
                              //   mtnActive = false;
                              //   airtelActive = false;
                              //   gloActive = true;
                              //   etisatActive = false;
                              //   buyDataFields.setServiceid = "glo-data";
                              //   fetchDataByServiceId(
                              //       buyDataFields.serviceid, context);
                              // });
                            },
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (gloActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(
                                    image: AssetImage("assets/images/glo.png")),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   isLoading = true;
                              //   mtnActive = false;
                              //   airtelActive = false;
                              //   gloActive = false;
                              //   etisatActive = true;
                              //   buyDataFields.setServiceid = "etisalat-data";
                              //   fetchDataByServiceId(
                              //       buyDataFields.serviceid, context);
                              // });
                            },
                            child: Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: (etisatActive)
                                      ? Border.all(color: fagoBlue, width: 2.0)
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
                        amount: amountController,
                        code: variationCode,
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
                          controller: phoneController,
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Image(
                                  image:
                                      AssetImage("assets/images/account.png")),
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
                                    phoneController.text =
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
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
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
                            if (phoneController.text.isEmpty ||
                                buyDataFields.serviceid.isEmpty ||
                                amountController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Kindly enter all fields'),
                                ),
                              );
                            } else {
                              setState(() {
                                buyDataFields.setPhone = phoneController.text;
                                buyDataFields.setBillersCode =
                                    phoneController.text;
                                buyDataFields.setAmount = amountController.text;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ConfirmTransactions(
                                      backRoute: const BuyData(),
                                      action: "buy_data",
                                    ),
                                  ),
                                );
                              });
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
    );
  }

  // void fetchDataByServiceId(String serviceId, BuildContext context) {
  //   ref
  //       .read(billControllerProvider.notifier)
  //       .getDatabyServiceId(serviceId)
  //       .then((value) {
  //     if (value.code != 200) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(value.message!),
  //         ),
  //       );
  //     } else {
  //       print('here');
  //       allData = value.dataValues!;
  //       dataDropdown = getBankList(allData!);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }

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
