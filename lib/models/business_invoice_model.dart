
class BusinessInvoiceResponse {
  Data? data;
  String? message;

  BusinessInvoiceResponse({
    this.data,
    this.message,
  });

  factory BusinessInvoiceResponse.fromJson(Map<String, dynamic> json) => BusinessInvoiceResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<InvoiceList>? invoiceList;
  int? totalInvoice;
  int? totalReceive;

  Data({
    this.invoiceList,
    this.totalInvoice,
    this.totalReceive,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoiceList: json["Invoice_List"] == null ? [] : List<InvoiceList>.from(json["Invoice_List"]!.map((x) => InvoiceList.fromJson(x))),
    totalInvoice: json["total_invoice"],
    totalReceive: json["total_receive"],
  );

  Map<String, dynamic> toJson() => {
    "Invoice_List": invoiceList == null ? [] : List<dynamic>.from(invoiceList!.map((x) => x.toJson())),
    "total_invoice": totalInvoice,
    "total_receive": totalReceive,
  };
}

class InvoiceList {
  String? id;
  String? invoiceNo;
  Customer? customer;
  Company? company;
  String? status;
  String? total;
  String? subtotal;
  dynamic paymentMode;
  String? discountRate;
  String? discountAmount;
  String? taxRate;
  String? taxAmount;
  String? createdBy;
  DateTime? createdAt;
  List<InvoiceDetail>? invoiceDetail;

  InvoiceList({
    this.id,
    this.invoiceNo,
    this.customer,
    this.company,
    this.status,
    this.total,
    this.subtotal,
    this.paymentMode,
    this.discountRate,
    this.discountAmount,
    this.taxRate,
    this.taxAmount,
    this.createdBy,
    this.createdAt,
    this.invoiceDetail,
  });

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    id: json["id"],
    invoiceNo: json["invoice_no"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    status: json["status"],
    total: json["total"],
    subtotal: json["subtotal"],
    paymentMode: json["payment_mode"],
    discountRate: json["discount_rate"],
    discountAmount: json["discount_amount"],
    taxRate: json["tax_rate"],
    taxAmount: json["tax_amount"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    invoiceDetail: json["invoice_detail"] == null ? [] : List<InvoiceDetail>.from(json["invoice_detail"]!.map((x) => InvoiceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_no": invoiceNo,
    "customer": customer?.toJson(),
    "company": company?.toJson(),
    "status": status,
    "total": total,
    "subtotal": subtotal,
    "payment_mode": paymentMode,
    "discount_rate": discountRate,
    "discount_amount": discountAmount,
    "tax_rate": taxRate,
    "tax_amount": taxAmount,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "invoice_detail": invoiceDetail == null ? [] : List<dynamic>.from(invoiceDetail!.map((x) => x.toJson())),
  };
}

class Company {
  String? id;
  String? rcNumber;
  String? companyName;
  dynamic emailAddress;
  dynamic branchAddress;
  dynamic city;
  dynamic address;
  String? companyStatus;
  dynamic lga;
  dynamic dateOfRegistration;
  dynamic state;
  dynamic companyType;

  Company({
    this.id,
    this.rcNumber,
    this.companyName,
    this.emailAddress,
    this.branchAddress,
    this.city,
    this.address,
    this.companyStatus,
    this.lga,
    this.dateOfRegistration,
    this.state,
    this.companyType,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    rcNumber: json["rc_number"],
    companyName: json["company_name"],
    emailAddress: json["email_address"],
    branchAddress: json["branchAddress"],
    city: json["city"],
    address: json["address"],
    companyStatus: json["company_status"],
    lga: json["lga"],
    dateOfRegistration: json["date_of_registration"],
    state: json["state"],
    companyType: json["company_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rc_number": rcNumber,
    "company_name": companyName,
    "email_address": emailAddress,
    "branchAddress": branchAddress,
    "city": city,
    "address": address,
    "company_status": companyStatus,
    "lga": lga,
    "date_of_registration": dateOfRegistration,
    "state": state,
    "company_type": companyType,
  };
}

class Customer {
  String? id;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? country;
  String? state;
  String? city;
  String? address;

  Customer({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.country,
    this.state,
    this.city,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    fullname: json["fullname"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone_number": phoneNumber,
    "email": email,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
  };
}

class InvoiceDetail {
  String? id;
  String? invoiceId;
  String? itemname;
  int? quantity;
  String? price;
  String? subTotal;
  String? total;
  dynamic description;
  String? discountRate;
  String? discountAmount;
  String? taxRate;
  String? taxAmount;
  DateTime? createdAt;

  InvoiceDetail({
    this.id,
    this.invoiceId,
    this.itemname,
    this.quantity,
    this.price,
    this.subTotal,
    this.total,
    this.description,
    this.discountRate,
    this.discountAmount,
    this.taxRate,
    this.taxAmount,
    this.createdAt,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
    id: json["id"],
    invoiceId: json["invoice_id"],
    itemname: json["itemname"],
    quantity: json["quantity"],
    price: json["price"],
    subTotal: json["sub_total"],
    total: json["total"],
    description: json["description"],
    discountRate: json["discount_rate"],
    discountAmount: json["discount_amount"],
    taxRate: json["tax_rate"],
    taxAmount: json["tax_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_id": invoiceId,
    "itemname": itemname,
    "quantity": quantity,
    "price": price,
    "sub_total": subTotal,
    "total": total,
    "description": description,
    "discount_rate": discountRate,
    "discount_amount": discountAmount,
    "tax_rate": taxRate,
    "tax_amount": taxAmount,
    "created_at": createdAt?.toIso8601String(),
  };
}
