class BankModel {
  late String _accountNo;
  late String _accountBank;
  late String _amount;
  late String _description;

  String get description => _description;

  set setDescription(String description) {
    _description = description;
  }

  String get amount => _amount;

  set setAmount(String amount) {
    _amount = amount;
  }

  String get accountBank => _accountBank;

  set setAccountBank(String accountBank) {
    _accountBank = accountBank;
  }

  String get accountNo => _accountNo;

  set setAccountNo(String accountNo) {
    _accountNo = accountNo;
  }
}

BankModel withdrawToBankDetails = BankModel();
