class SalesModel {
  String accountType;
  String bankAccount;
  String balance;

  SalesModel(
      {required this.accountType,
      required this.bankAccount,
      required this.balance});
}

List<SalesModel> salesContent = [
    SalesModel(
        accountType: "Sales Account",
        bankAccount: "2038173855 | GTB",
        balance: "900,340.00"),
    SalesModel(
        accountType: "Sales Account",
        bankAccount: "2038173855 | GTB",
        balance: "900,340.00"),
    SalesModel(
        accountType: "Sales Account",
        bankAccount: "2038173855 | GTB",
        balance: "900,340.00"),
  ];
