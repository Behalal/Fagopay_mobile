class BookKeepingModel {
  String accountType;
  String description;
  String balance;
  String imagePath;

  BookKeepingModel(
      {required this.accountType,
      required this.description,
      required this.balance,
      required this.imagePath
      }
  );
}

List<BookKeepingModel> bookKeepingContent = [
  BookKeepingModel(
      accountType: "Total Inflow",
      description: "Income",
      balance: "900,340.00",
      imagePath: "assets/images/inflow.png",
    ),
  BookKeepingModel(
      accountType: "Total Outflow",
      description: "Expenses",
      balance: "900,340.00",
      imagePath: "assets/images/outflow.png",
    ),
  BookKeepingModel(
      accountType: "Total Credit",
      description: "#600,000 retrieved",
      balance: "0.00",
      imagePath: "assets/images/total_credit.png",
    ),
  BookKeepingModel(
      accountType: "Sales Account",
      description: "Customer’s Debt",
      balance: "0.00",
      imagePath: "assets/images/outstanding.png",
    ),
];
