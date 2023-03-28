import 'package:fagopay/models/auth_model/auth.dart';
import 'package:fagopay/models/data_model.dart';
import 'package:fagopay/service/biils_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillRepository {
  final BillService service;
  BillRepository(this.service);

  Future<Auth> buyAirtime(String phone, String serviceID, String amount,
      String transactionPin) async {
    String response =
        await service.buyAirtime(phone, serviceID, amount, transactionPin);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Data> getDataByServiceId(String serviceID) async {
    String response = await service.getDataCodesByServiceId(serviceID);
    Data billResponse = Data.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> buyData(String phone, String serviceID, String variationCode,
      String billerCode, String amount, String transactionPin) async {
    String response = await service.buyData(
        phone, serviceID, variationCode, billerCode, amount, transactionPin);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> verifyInternetNo(String billerCode) async {
    String response = await service.verifyInternrtNo(billerCode);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> buyInternet(String phone, String serviceID, String variationCode,
      String billerCode, String amount, String transactionPin) async {
    String response = await service.buyInternet(
        phone, serviceID, variationCode, billerCode, amount, transactionPin);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> verifyMeterNo(
      String serviceID, String billerCode, String type) async {
    String response = await service.verifyMeterNo(serviceID, billerCode, type);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> buyElectricity(
      String phone,
      String serviceID,
      String variationCode,
      String billerCode,
      String amount,
      String transactionPin) async {
    String response = await service.buyElectricity(
        phone, serviceID, variationCode, billerCode, amount, transactionPin);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> verifySmartCard( String serviceID, String billerCode ) async {
    String response = await service.verifySmartCard(billerCode, serviceID);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }

  Future<Auth> cableSubscription(String phone, String serviceID, String variationCode,
      String billerCode, String amount, String transactionPin) async {
    String response = await service.cableSubscription(phone, serviceID, variationCode, billerCode, amount, transactionPin);
    Auth billResponse = Auth.fromReqBody(response);
    billResponse.printAttributes();
    return billResponse;
  }
}

final billRepositoryProvider = Provider<BillRepository>((ref) {
  return BillRepository(ref.read(billServiceProvider));
});
