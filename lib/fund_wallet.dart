import 'dart:developer';
import 'package:fagopay/controllers/transaction_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class RequestPayWithCardPayment{
  final String encryptionKey;
  final String publicKey;
  final String amount;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String reference;
  final BuildContext context;
  RequestPayWithCardPayment(this.encryptionKey, this.publicKey, this.amount, this.email, this.phoneNumber, this.fullName, this.context, this.reference);

  String _getReference() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  chargeCard() async {
    final ctrl =  Get.find<TransactionController>();
    final Flutterwave flutterWave = Flutterwave(
        context: context,
        publicKey: publicKey,
        currency: "NGN",
        redirectUrl: 'https://facebook.com',
        txRef: reference,
        //_getReference(),
        amount: amount,
        customer: Customer(email: email, name: fullName, phoneNumber: phoneNumber),
        paymentOptions: "card",
        //"card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Payment", description: "Payment for an item with card", logo: "assets/images/logo.png"),
        isTestMode: false
    );

    try{
      final ChargeResponse response = await flutterWave.charge();
      if (response.success!) {
        log(response.txRef.toString());
        await ctrl.verificationCallBack(reference: response.txRef!);
      } else {
        Get.snackbar("Error","Opps! Something went wrong", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }
    }catch (error){
      log(error.toString());
    }
  }
}

