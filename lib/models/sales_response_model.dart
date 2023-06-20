
class SalesResponseModel {
  Data? data;
  String? message;

  SalesResponseModel({
    this.data,
    this.message,
  });

  factory SalesResponseModel.fromJson(Map<String, dynamic> json) => SalesResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<SalesList>? salesList;
  int? totalCredit;
  int? totalOutstanding;

  Data({
    this.salesList,
    this.totalCredit,
    this.totalOutstanding,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    salesList: json["sales_list"] == null ? [] : List<SalesList>.from(json["sales_list"]!.map((x) => SalesList.fromJson(x))),
    totalCredit: json["total_credit"],
    totalOutstanding: json["total_outstanding"],
  );

  Map<String, dynamic> toJson() => {
    "sales_list": salesList == null ? [] : List<dynamic>.from(salesList!.map((x) => x.toJson())),
    "total_credit": totalCredit,
    "total_outstanding": totalOutstanding,
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
