// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/individual/purse/create_purse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/purse_controller.dart';
import '../../../functions/constant.dart';
import '../../../models/purse/purse_list_model.dart';
import '../../constants/colors.dart';

class MyPurse extends StatefulWidget {
  const MyPurse({
    super.key,
  });

  @override
  State<MyPurse> createState() => _MyPurseState();
}

class _MyPurseState extends State<MyPurse> {
  final _purseController = Get.find<PurseController>();

  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AutoSizeText(
              'My Purse',
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: fagoSecondaryColor,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
            SizedBox(
              height: 2.h,
            ),
            FutureBuilder<PurseListModel>(
                future: _purseController.purseList(),
                builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data;
                return data.pulseList.isNotEmpty?
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h,horizontal: 4.w),
                        width:  double.infinity,
                        decoration: BoxDecoration(
                          color: fagoSecondaryColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name :',style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: white)),

                                Text(data.pulseList[0].name,style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: white)),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount :',style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: white)),

                                Text(  Constant().formatCurrency.format(double.parse(data.pulseList[0].amount)),style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: white)),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Duration :',style: Constant().textStyle(size: 14, weight: FontWeight.w500,color: white)),

                                Text(data.pulseList[0].duration,style: Constant().textStyle(size: 16, weight: FontWeight.w600,color: white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.5.h,),
                      Text('Categories',style: Constant().textStyle(size: 17, weight: FontWeight.w600,color: black)),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          itemCount: data.pulseList[0].pulseCategories.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,i){
                            var dataB = data.pulseList[0].pulseCategories[i];
                            return ListTile(
                              title: Text(
                                dataB.categoryName,
                                style: Constant().textStyle(size: 16, weight: FontWeight.w500,color: black),
                              ),
                              trailing: Text(
                                Constant().formatCurrency.format(double.parse(dataB.budgetedAmount),),
                                style: Constant().textStyle(size: 16, weight: FontWeight.w500,color: black),
                              ),
                              );
                            },
                        ),
                       ),
                     SizedBox(height: 2.h,),
                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 8.w),
                       child: Constant().longBtn(text: 'Edit Purse',color: fagoSecondaryColor,tap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>  CreatePurse(isEdit: true,pulseList: data,)));
                       },radius: 25,textStyle:Constant().textStyle(size: 16.6, weight: FontWeight.w600,color: white )),
                     ),
                    ],
                  ),
                ):
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.h, vertical: 2.h),
                                    //height: 27.h,
                                    width: Get.width,
                                    color: fagoSecondaryColorWithOpacity10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/purse_icon.svg'),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        const AutoSizeText(
                                          'No Purse yet',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: stepsColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        const AutoSizeText(
                                          'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: stepsColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => const CreatePurse());
                                          },
                                          child: Container(
                                            height: 5.h,
                                            width: 23.5.h,
                                            decoration: BoxDecoration(
                                                color: fagoSecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: fagoSecondaryColor)),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const AutoSizeText(
                                                  'Create a Purse',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: white,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    'assets/icons/create_wallet.svg')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                ],
                              )),
                        ),
                      ]),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(
                child: LoadingWidget(
                  color: fagoSecondaryColor,
                  size: 16,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
