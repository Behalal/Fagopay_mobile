
class CustomerDetailsResponseModel {
  Data? data;
  String? message;

  CustomerDetailsResponseModel({
    this.data,
    this.message,
  });

  factory CustomerDetailsResponseModel.fromJson(Map<String, dynamic> json) => CustomerDetailsResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  CustomerDetails? customer;

  Data({
    this.customer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer: json["customer"] == null ? null : CustomerDetails.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
  };
}

class CustomerDetails {
  String? id;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? countryId;
  String? stateId;
  String? cityId;
  String? address;
  String? companyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Company? company;
  List<CustomerTransaction>? customerTransactions;

  CustomerDetails({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.countryId,
    this.stateId,
    this.cityId,
    this.address,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.customerTransactions,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
    id: json["id"],
    fullname: json["fullname"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    address: json["address"],
    companyId: json["company_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    customerTransactions: json["customer_transactions"] == null ? [] : List<CustomerTransaction>.from(json["customer_transactions"]!.map((x) => CustomerTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone_number": phoneNumber,
    "email": email,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "address": address,
    "company_id": companyId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "company": company?.toJson(),
    "customer_transactions": customerTransactions == null ? [] : List<dynamic>.from(customerTransactions!.map((x) => x.toJson())),
  };
}

class Company {
  String? id;
  String? rcNumber;
  String? companyName;
  String? rcType;
  String? documentUrl;
  int? otpVerified;
  int? isVerified;
  String? userId;

  Company({
    this.id,
    this.rcNumber,
    this.companyName,
    this.rcType,
    this.documentUrl,
    this.otpVerified,
    this.isVerified,
    this.userId,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    rcNumber: json["rc_number"],
    companyName: json["company_name"],
    rcType: json["rc_type"],
    documentUrl: json["document_url"],
    otpVerified: json["otp_verified"],
    isVerified: json["is_verified"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rc_number": rcNumber,
    "company_name": companyName,
    "rc_type": rcType,
    "document_url": documentUrl,
    "otp_verified": otpVerified,
    "is_verified": isVerified,
    "user_id": userId,
  };
}

class CustomerTransaction {
  String? id;
  String? customerId;
  String? companyId;
  String? reference;
  String? status;
  String? total;
  String? subtotal;
  String? amountPaid;
  dynamic transactionId;
  dynamic paymentMode;
  String? discountRate;
  String? discountAmount;
  String? taxRate;
  String? taxAmount;
  String? markAsPaidBy;
  DateTime? paidOn;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomerTransaction({
    this.id,
    this.customerId,
    this.companyId,
    this.reference,
    this.status,
    this.total,
    this.subtotal,
    this.amountPaid,
    this.transactionId,
    this.paymentMode,
    this.discountRate,
    this.discountAmount,
    this.taxRate,
    this.taxAmount,
    this.markAsPaidBy,
    this.paidOn,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerTransaction.fromJson(Map<String, dynamic> json) => CustomerTransaction(
    id: json["id"],
    customerId: json["customer_id"],
    companyId: json["company_id"],
    reference: json["reference"],
    status: json["status"],
    total: json["total"],
    subtotal: json["subtotal"],
    amountPaid: json["amount_paid"],
    transactionId: json["transaction_id"],
    paymentMode: json["payment_mode"],
    discountRate: json["discount_rate"],
    discountAmount: json["discount_amount"],
    taxRate: json["tax_rate"],
    taxAmount: json["tax_amount"],
    markAsPaidBy: json["mark_as_paid_by"],
    paidOn: json["paid_on"] == null ? null : DateTime.parse(json["paid_on"]),
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "company_id": companyId,
    "reference": reference,
    "status": status,
    "total": total,
    "subtotal": subtotal,
    "amount_paid": amountPaid,
    "transaction_id": transactionId,
    "payment_mode": paymentMode,
    "discount_rate": discountRate,
    "discount_amount": discountAmount,
    "tax_rate": taxRate,
    "tax_amount": taxAmount,
    "mark_as_paid_by": markAsPaidBy,
    "paid_on": "${paidOn!.year.toString().padLeft(4, '0')}-${paidOn!.month.toString().padLeft(2, '0')}-${paidOn!.day.toString().padLeft(2, '0')}",
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
