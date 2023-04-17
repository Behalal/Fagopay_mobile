class BankTransferFields {
  String _bankId = "";
  String _accountNumber = "";
  String _phoneNumber = "";
  String _accountName = "";
  String _amount = "";
  String _narration = "";

  String get amount => _amount;

  set setAmount(String amount) {
    _amount = amount;
  }

  String get phoneNumber => _phoneNumber;

  set setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  String get accountName => _accountName;

  set setAccountName(String accountName) {
    _accountName = accountName;
  }

  String get bankId => _bankId;

  set setBankId(String bankId) {
    _bankId = bankId;
  }

  String get accountNumber => _accountNumber;

  set setAccountNumber(String accountNumber) {
    _accountNumber = accountNumber;
  }

  String get narration => _narration;

  set setNarration(String narration) {
    _narration = narration;
  }
}

BankTransferFields bankTransferFields = BankTransferFields();
