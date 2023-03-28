class BuyAirtimeFields {
  late String _phone;
  late String _serviceid;
  late String _amount;

  String get amount => _amount;

  set setAmount(String amount) {
    _amount = amount;
  }

  String get serviceid => _serviceid;

  set setServiceid(String serviceid) {
    _serviceid = serviceid;
  }

  String get getphone => _phone;

  set setPhone(String phone) {
    _phone = phone;
  }
}

class BuyDataFields {
  late String _phone;
  late String _serviceid;
  late String _amount;
  late String _variationCode;
  late String _billersCode;
  late String _name;

  String get name => _name;

  set setName(String name) {
    _name = name;
  }

  String get billersCode => _billersCode;

  set setBillersCode(String billersCode) {
    _billersCode = billersCode;
  }

  String get variationCode => _variationCode;

  set getVariationCode(String variationCode) {
    _variationCode = variationCode;
  }

  String get amount => _amount;

  set setAmount(String amount) {
    _amount = amount;
  }

  String get serviceid => _serviceid;

  set setServiceid(String serviceid) {
    _serviceid = serviceid;
  }

  String get getphone => _phone;

  set setPhone(String phone) {
    _phone = phone;
  }
}

BuyAirtimeFields buyAirtimeFields = BuyAirtimeFields();
BuyDataFields buyDataFields = BuyDataFields();
BuyDataFields buyElectricityFields = BuyDataFields();
BuyDataFields buyInternetFields = BuyDataFields();
