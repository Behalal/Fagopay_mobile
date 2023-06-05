import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'constant.dart';

class Functions {
  bool validateEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  bool validatePhone(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(phone);

    return validPhone;
  }

  bool checkUpperCase(String value) {
    String pattern = r'[A-Z]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool checkLoweCase(String value) {
    String pattern = r'[a-z]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool checknumbers(String value) {
    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool specialCharacters(String value) {
    String pattern = r'[!@#$%^&*(),.?]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }
  paymentDialPopUp({required VoidCallback onTap, required BuildContext context}){
    String pin1 =  '';
    String pin2 =  '';
    String pin3 =  '';
    String pin4 =  '';
    Container pinTextField({required BuildContext context,required String text}){
      return  Container(
          decoration: BoxDecoration(
              color: const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(6)
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 13),
          width: 50,
          height: 50,
          child: Text(text.isNotEmpty?'*':text,style: Constant().textStyle(size: text.isNotEmpty?25:15,weight: FontWeight.w600, color: fagoSecondaryColor,),)
      );
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (s){
          return  StatefulBuilder(
              builder: (BuildContext context, setState) {
                return  SingleChildScrollView(
                  child: SizedBox(
                    child: BottomSheet(
                      enableDrag:true,
                      shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))),
                      onClosing: () {},
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              paymentDialButton({required String text,required BuildContext context,}){
                                return GestureDetector(
                                  onTap: (){
                                    if(pin1.isEmpty){
                                      setState(() {
                                        pin1 = text;
                                      });
                                    }else if(pin2.isEmpty){
                                      setState(() {
                                        pin2 = text;
                                      });
                                    }else if(pin3.isEmpty){
                                      setState(() {
                                        pin3 = text;
                                      });

                                    }else if(pin4.isEmpty){
                                      setState(() {
                                        pin4 = text;
                                      });
                                      print('$pin1 $pin2 $pin3 $pin4');
                                    }
                                  },
                                  child: Container(
                                    width: 54,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: const Offset(0, 2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                    child: Text(text,style:
                                    Constant().textStyle(size:23,weight: FontWeight.w700, color: fagoSecondaryColor,)
                                  ),
                                  ),
                                );
                              }
                              popUpRowPaymentDial({required String one,required String two, required String three,required BuildContext context}){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      paymentDialButton(text: one,context: context),
                                      const SizedBox(width: 10,),
                                      paymentDialButton(text: two,context: context),
                                      const SizedBox(width: 10,),
                                      paymentDialButton(text: three,context: context),
                                    ],
                                  ),
                                );
                              }
                              return  Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0,bottom: 5),
                                    child: Center(child: Text('Enter Payment Pin',style:
                                     Constant().textStyle(size: 16,weight: FontWeight.w600, color: fagoSecondaryColor,)
                                   )),
                                  ),
                                  // const SizedBox(height: 3,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      pinTextField(text: pin1, context: context),
                                      pinTextField(text: pin2, context: context),
                                      pinTextField(text: pin3, context: context),
                                      pinTextField(text: pin4, context: context),
                                    ],
                                  ),
                                  const SizedBox(height: 6,),
                                  popUpRowPaymentDial(context: context,one: '1',two: '2',three: '3'),
                                  popUpRowPaymentDial(context: context,one: '4',two: '5',three: '6'),
                                  popUpRowPaymentDial(context: context,one: '7',two: '8',three: '9'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 54,
                                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                          child: Text('',style:Constant().textStyle(size:23,weight: FontWeight.w700, color: fagoSecondaryColor,)),
                                        ),
                                        paymentDialButton(context: context,text: '0'),
                                        GestureDetector(
                                          onTap: (){
                                            if(pin4.isNotEmpty){
                                              setState(() {
                                                pin4 = '';
                                              });
                                            }
                                            else if(pin3.isNotEmpty){
                                              setState(() {
                                                pin3 = '';
                                              });
                                            }
                                            else if(pin2.isNotEmpty){
                                              setState(() {
                                                pin2 = '';
                                              });
                                            }
                                            else if(pin1.isNotEmpty){
                                              setState(() {
                                                pin1 = '';
                                              });
                                            }
                                            else{
                                              print('all emmpty');
                                            }
                                          },
                                          child: Container(
                                            // margin: EdgeInsets.only(left: 20),
                                              width: 54,
                                              height: 52,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 1,
                                                    offset: const Offset(0, 2), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              //padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 23),
                                              child: const Icon(Icons.cancel)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 9,),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  //   child: Constant().longBtn(text: 'Proceed',tap: (){
                                  //     if(pin1.isNotEmpty & pin2.isNotEmpty & pin3.isNotEmpty & pin4.isNotEmpty){
                                  //     //  Provider.of<AppProvider>(context,listen: false).changePin(pin: '$pin1$pin2$pin3$pin4');
                                  //       onTap();
                                  //     }else{
                                  //       Get.snackbar(
                                  //           'Error',
                                  //           'input pin to proceed'
                                  //       );
                                  //       //AppWidgets().toast(message: 'input pin to proceed',color: AppColors().red);
                                  //     }
                                  //   }),
                                  // ),
                                   SizedBox(height: 5.h,),
                                ],
                              );
                            }
                        );
                      },
                    ),
                  ),
                );
              }
          );
        }
    );
  }
  popUp({required BuildContext context, required Widget widget}){
    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: context, builder: (BuildContext context) {
          return widget;
      },
    );
  }
}
