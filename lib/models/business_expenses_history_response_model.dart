// To parse this JSON data, do
//
//     final businessSalesExpensesHistoryResponse = businessSalesExpensesHistoryResponseFromJson(jsonString);

import 'dart:convert';

BusinessSalesExpensesHistoryResponse businessSalesExpensesHistoryResponseFromJson(String str) => BusinessSalesExpensesHistoryResponse.fromJson(json.decode(str));

String businessSalesExpensesHistoryResponseToJson(BusinessSalesExpensesHistoryResponse data) => json.encode(data.toJson());

class BusinessSalesExpensesHistoryResponse {
  Data? data;
  String? message;

  BusinessSalesExpensesHistoryResponse({
    this.data,
    this.message,
  });

  factory BusinessSalesExpensesHistoryResponse.fromJson(Map<String, dynamic> json) => BusinessSalesExpensesHistoryResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  SalesExpenses? salesExpenses;

  Data({
    this.salesExpenses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    salesExpenses: json["sales_expenses"] == null ? null : SalesExpenses.fromJson(json["sales_expenses"]),
  );

  Map<String, dynamic> toJson() => {
    "sales_expenses": salesExpenses?.toJson(),
  };
}

class SalesExpenses {
  List<SalesList>? salesList;
  List<ExpensesList>? expensesList;
  int? totalInflow;
  int? totalOutflow;

  SalesExpenses({
    this.salesList,
    this.expensesList,
    this.totalInflow,
    this.totalOutflow,
  });

  factory SalesExpenses.fromJson(Map<String, dynamic> json) => SalesExpenses(
    salesList: json["sales_list"] == null ? [] : List<SalesList>.from(json["sales_list"]!.map((x) => SalesList.fromJson(x))),
    expensesList: json["expenses_list"] == null ? [] : List<ExpensesList>.from(json["expenses_list"]!.map((x) => ExpensesList.fromJson(x))),
    totalInflow: json["total_inflow"],
    totalOutflow: json["total_outflow"],
  );

  Map<String, dynamic> toJson() => {
    "sales_list": salesList == null ? [] : List<dynamic>.from(salesList!.map((x) => x.toJson())),
    "expenses_list": expensesList == null ? [] : List<dynamic>.from(expensesList!.map((x) => x.toJson())),
    "total_inflow": totalInflow,
    "total_outflow": totalOutflow,
  };
}

class ExpensesList {
  String? id;
  dynamic reason;
  DateTime? expenseDate;
  String? note;
  String? amount;
  Supplier? supplier;
  String? createdBy;
  String? category;

  ExpensesList({
    this.id,
    this.reason,
    this.expenseDate,
    this.note,
    this.amount,
    this.supplier,
    this.createdBy,
    this.category,
  });

  factory ExpensesList.fromJson(Map<String, dynamic> json) => ExpensesList(
    id: json["id"],
    reason: json["reason"],
    expenseDate: json["expense_date"] == null ? null : DateTime.parse(json["expense_date"]),
    note: json["note"],
    amount: json["amount"],
    supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
    createdBy: json["created_by"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
    "expense_date": "${expenseDate!.year.toString().padLeft(4, '0')}-${expenseDate!.month.toString().padLeft(2, '0')}-${expenseDate!.day.toString().padLeft(2, '0')}",
    "note": note,
    "amount": amount,
    "supplier": supplier?.toJson(),
    "created_by": createdBy,
    "category": category,
  };
}

class Supplier {
  String? id;
  int? bankCode;
  String? accountNumber;
  String? accountName;
  String? name;
  String? email;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? address;
  String? companyId;
  List<Transaction>? transactions;

  Supplier({
    this.id,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.state,
    this.city,
    this.address,
    this.companyId,
    this.transactions,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    bankCode: json["bank_code"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    companyId: json["company_id"],
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_code": bankCode,
    "account_number": accountNumber,
    "account_name": accountName,
    "name": name,
    "email": email,
    "phone": phone,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "company_id": companyId,
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  String? id;
  String? supplierId;
  String? companyId;
  String? amount;
  dynamic reason;
  String? expenseCategory;
  DateTime? expenseDate;
  String? note;
  String? createdBy;

  Transaction({
    this.id,
    this.supplierId,
    this.companyId,
    this.amount,
    this.reason,
    this.expenseCategory,
    this.expenseDate,
    this.note,
    this.createdBy,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    supplierId: json["supplier_id"],
    companyId: json["company_id"],
    amount: json["amount"],
    reason: json["reason"],
    expenseCategory: json["expense_category"],
    expenseDate: json["expense_date"] == null ? null : DateTime.parse(json["expense_date"]),
    note: json["note"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplier_id": supplierId,
    "company_id": companyId,
    "amount": amount,
    "reason": reason,
    "expense_category": expenseCategory,
    "expense_date": "${expenseDate!.year.toString().padLeft(4, '0')}-${expenseDate!.month.toString().padLeft(2, '0')}-${expenseDate!.day.toString().padLeft(2, '0')}",
    "note": note,
    "created_by": createdBy,
  };
}

class SalesList {
  String? id;
  String? customerId;
  String? customerName;
  String? companyId;
  String? salesAmount;
  String? amountPaid;
  String? paymentStatus;
  DateTime? salesDate;
  String? salesDescription;
  String? createdBy;

  SalesList({
    this.id,
    this.customerId,
    this.customerName,
    this.companyId,
    this.salesAmount,
    this.amountPaid,
    this.paymentStatus,
    this.salesDate,
    this.salesDescription,
    this.createdBy,
  });

  factory SalesList.fromJson(Map<String, dynamic> json) => SalesList(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    companyId: json["company_id"],
    salesAmount: json["sales_amount"],
    amountPaid: json["amount_paid"],
    paymentStatus: json["payment_status"],
    salesDate: json["sales_date"] == null ? null : DateTime.parse(json["sales_date"]),
    salesDescription: json["sales_description"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "customer_name": customerName,
    "company_id": companyId,
    "sales_amount": salesAmount,
    "amount_paid": amountPaid,
    "payment_status": paymentStatus,
    "sales_date": "${salesDate!.year.toString().padLeft(4, '0')}-${salesDate!.month.toString().padLeft(2, '0')}-${salesDate!.day.toString().padLeft(2, '0')}",
    "sales_description": salesDescription,
    "created_by": createdBy,
  };
}
