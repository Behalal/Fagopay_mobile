
class SupplierDetailModel {
  Data? data;
  String? message;

  SupplierDetailModel({
    this.data,
    this.message,
  });

  factory SupplierDetailModel.fromJson(Map<String, dynamic> json) => SupplierDetailModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  SupplierDetail? supplierDetail;

  Data({
    this.supplierDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    supplierDetail: json["supplier_detail"] == null ? null : SupplierDetail.fromJson(json["supplier_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "supplier_detail": supplierDetail?.toJson(),
  };
}

class SupplierDetail {
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

  SupplierDetail({
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

  factory SupplierDetail.fromJson(Map<String, dynamic> json) => SupplierDetail(
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
