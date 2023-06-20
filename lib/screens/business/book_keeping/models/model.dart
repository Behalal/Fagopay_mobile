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
      accountType: " Total Invoice",
      description: "Income",
      balance: "900,340.00",
      imagePath: "assets/images/inflow.svg",
    ),
  BookKeepingModel(
      accountType: " Total Received",
      description: "Expenses",
      balance: "900,340.00",
      imagePath: "assets/images/outflow.svg",
    ),
  BookKeepingModel(
      accountType: "Total Outstanding",
      description: "#600,000 retrieved",
      balance: "0.00",
      imagePath: "assets/images/total_credit.svg",
    ),
  BookKeepingModel(
      accountType: "Sales Account",
      description: "Customer’s Debt",
      balance: "0.00",
      imagePath: "assets/images/total_debit.svg",
    ),
];
