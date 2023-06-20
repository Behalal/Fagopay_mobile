// To parse this JSON data, do
//
//     final userDetailsResponse = userDetailsResponseFromJson(jsonString);

import 'dart:convert';

UserDetailsResponse userDetailsResponseFromJson(String str) => UserDetailsResponse.fromJson(json.decode(str));

String userDetailsResponseToJson(UserDetailsResponse data) => json.encode(data.toJson());

class UserDetailsResponse {
  Data? data;
  String? message;

  UserDetailsResponse({
    this.data,
    this.message,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) => UserDetailsResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  UserDetail? userdetail;
  BusinessDetail? businessDetail;

  Data({
    this.userdetail,
    this.businessDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userdetail: json["userdetail"] == null ? null : UserDetail.fromJson(json["userdetail"]),
    businessDetail: json["business_detail"] == null ? null : BusinessDetail.fromJson(json["business_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "userdetail": userdetail?.toJson(),
    "business_detail": businessDetail?.toJson(),
  };
}

class BusinessDetail {
  List<Profile>? profile;

  BusinessDetail({
    this.profile,
  });

  factory BusinessDetail.fromJson(Map<String, dynamic> json) => BusinessDetail(
    profile: json["profile"] == null ? [] : List<Profile>.from(json["profile"]!.map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile == null ? [] : List<dynamic>.from(profile!.map((x) => x.toJson())),
  };
}

class Profile {
  String? id;
  String? rcNumber;
  String? companyName;
  String? companyStatus;
  String? userId;
  dynamic companyType;
  num? verificationStatus;
  List<Customer>? customer;
  List<Supplier>? suppliers;
  List<Sale>? sales;
  List<dynamic>? staff;
  Account? account;

  Profile({
    this.id,
    this.rcNumber,
    this.companyName,
    this.companyStatus,
    this.userId,
    this.companyType,
    this.verificationStatus,
    this.customer,
    this.suppliers,
    this.sales,
    this.staff,
    this.account,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    rcNumber: json["rc_number"],
    companyName: json["company_name"],
    companyStatus: json["company_status"],
    userId: json["user_id"],
    companyType: json["company_type"],
    verificationStatus: json["verification_status"],
    customer: json["customer"] == null ? [] : List<Customer>.from(json["customer"]!.map((x) => Customer.fromJson(x))),
    suppliers: json["suppliers"] == null ? [] : List<Supplier>.from(json["suppliers"]!.map((x) => Supplier.fromJson(x))),
    sales: json["sales"] == null ? [] : List<Sale>.from(json["sales"]!.map((x) => Sale.fromJson(x))),
    staff: json["staff"] == null ? [] : List<dynamic>.from(json["staff"]!.map((x) => x)),
    account: json["account"] == null ? null : Account.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rc_number": rcNumber,
    "company_name": companyName,
    "company_status": companyStatus,
    "user_id": userId,
    "company_type": companyType,
    "verification_status": verificationStatus,
    "customer": customer == null ? [] : List<dynamic>.from(customer!.map((x) => x.toJson())),
    "suppliers": suppliers == null ? [] : List<dynamic>.from(suppliers!.map((x) => x.toJson())),
    "sales": sales == null ? [] : List<dynamic>.from(sales!.map((x) => x.toJson())),
    "staff": staff == null ? [] : List<dynamic>.from(staff!.map((x) => x)),
    "account": account?.toJson(),
  };
}

class Account {
  String? id;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? status;
  String? currency;
  String? manager;
  dynamic balance;
  List<SubAccount>? subAccount;

  Account({
    this.id,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.accountType,
    this.status,
    this.currency,
    this.manager,
    this.balance,
    this.subAccount,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    accountType: json["account_type"],
    status: json["status"],
    currency: json["currency"],
    manager: json["manager"],
    balance: json["balance"],
    subAccount: json["sub_account"] == null ? [] : List<SubAccount>.from(json["sub_account"]!.map((x) => SubAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "account_type": accountType,
    "status": status,
    "currency": currency,
    "manager": manager,
    "balance": balance,
    "sub_account": subAccount == null ? [] : List<dynamic>.from(subAccount!.map((x) => x.toJson())),
  };
}

class SubAccount {
  String? id;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? status;
  String? currency;
  String? manager;
  String? balance;

  SubAccount({
    this.id,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.accountType,
    this.status,
    this.currency,
    this.manager,
    this.balance,
  });

  factory SubAccount.fromJson(Map<String, dynamic> json) => SubAccount(
    id: json["id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    accountType: json["account_type"],
    status: json["status"],
    currency: json["currency"],
    manager: json["manager"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "account_type": accountType,
    "status": status,
    "currency": currency,
    "manager": manager,
    "balance": balance,
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

class Sale {
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

  Sale({
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

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
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

class Supplier {
  String? id;
  num? bankCode;
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
  };
}

class UserDetail {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? dateOfBirth;
  DateTime? phoneVerifiedAt;
  num? bvnVerified;
  dynamic identifier;
  String? bvnId;
  num? kycVerified;
  dynamic emailVerifiedAt;
  String? referalCode;
  String? referalBy;
  num? recoveryMode;
  num? loginAttempt;
  dynamic deviceId;
  dynamic ipaddress;
  String? accountTier;
  String? accountDailyLimit;
  num? isRestricted;
  String? isDissabled;
  DateTime? lastLogin;
  num? hasGovernmentIdentity;
  num? accountType;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? balanceDisplayMode;
  Nextofkin? nextofkin;
  AccountDetail? accountdetail;

  UserDetail({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.gender,
    this.phoneNumber,
    this.dateOfBirth,
    this.phoneVerifiedAt,
    this.bvnVerified,
    this.identifier,
    this.bvnId,
    this.kycVerified,
    this.emailVerifiedAt,
    this.referalCode,
    this.referalBy,
    this.recoveryMode,
    this.loginAttempt,
    this.deviceId,
    this.ipaddress,
    this.accountTier,
    this.accountDailyLimit,
    this.isRestricted,
    this.isDissabled,
    this.lastLogin,
    this.hasGovernmentIdentity,
    this.accountType,
    this.createdAt,
    this.updatedAt,
    this.balanceDisplayMode,
    this.nextofkin,
    this.accountdetail,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    dateOfBirth: json["date_of_birth"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    bvnVerified: json["bvn_verified"],
    identifier: json["identifier"],
    bvnId: json["bvn_id"],
    kycVerified: json["kyc_verified"],
    emailVerifiedAt: json["email_verified_at"],
    referalCode: json["referal_code"],
    referalBy: json["referal_by"],
    recoveryMode: json["recovery_mode"],
    loginAttempt: json["login_attempt"],
    deviceId: json["device_id"],
    ipaddress: json["ipaddress"],
    accountTier: json["account_tier"],
    accountDailyLimit: json["account_daily_limit"],
    isRestricted: json["is_restricted"],
    isDissabled: json["is_dissabled"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    hasGovernmentIdentity: json["has_government_identity"],
    accountType: json["account_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    balanceDisplayMode: json["balance_display_mode"],
    nextofkin: json["nextofkin"] == null ? null : Nextofkin.fromJson(json["nextofkin"]),
    accountdetail: json["accountdetail"] == null ? null : AccountDetail.fromJson(json["accountdetail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "gender": gender,
    "phone_number": phoneNumber,
    "date_of_birth": dateOfBirth,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "bvn_verified": bvnVerified,
    "identifier": identifier,
    "bvn_id": bvnId,
    "kyc_verified": kycVerified,
    "email_verified_at": emailVerifiedAt,
    "referal_code": referalCode,
    "referal_by": referalBy,
    "recovery_mode": recoveryMode,
    "login_attempt": loginAttempt,
    "device_id": deviceId,
    "ipaddress": ipaddress,
    "account_tier": accountTier,
    "account_daily_limit": accountDailyLimit,
    "is_restricted": isRestricted,
    "is_dissabled": isDissabled,
    "last_login": lastLogin?.toIso8601String(),
    "has_government_identity": hasGovernmentIdentity,
    "account_type": accountType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "balance_display_mode": balanceDisplayMode,
    "nextofkin": nextofkin?.toJson(),
    "accountdetail": accountdetail?.toJson(),
  };
}

class AccountDetail {
  String? id;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? status;
  String? currency;
  dynamic manager;
  num? balance;

  AccountDetail({
    this.id,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.accountType,
    this.status,
    this.currency,
    this.manager,
    this.balance,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
    id: json["id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    accountType: json["account_type"],
    status: json["status"],
    currency: json["currency"],
    manager: json["manager"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "account_type": accountType,
    "status": status,
    "currency": currency,
    "manager": manager,
    "balance": balance,
  };
}

class Nextofkin {
  String? id;
  String? userId;
  String? fullName;
  String? bussinessId;
  String? email;
  String? phoneNumber;
  String? houseAddress;
  String? relationship;

  Nextofkin({
    this.id,
    this.userId,
    this.fullName,
    this.bussinessId,
    this.email,
    this.phoneNumber,
    this.houseAddress,
    this.relationship,
  });

  factory Nextofkin.fromJson(Map<String, dynamic> json) => Nextofkin(
    id: json["id"],
    userId: json["user_id"],
    fullName: json["full_name"],
    bussinessId: json["bussiness_id"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    houseAddress: json["house_address"],
    relationship: json["relationship"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "full_name": fullName,
    "bussiness_id": bussinessId,
    "email": email,
    "phone_number": phoneNumber,
    "house_address": houseAddress,
    "relationship": relationship,
  };
}
