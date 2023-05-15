// To parse this JSON data, do
//
//     final newUserModel = newUserModelFromJson(jsonString);

import 'dart:convert';

NewUserModel newUserModelFromJson(String str) => NewUserModel.fromJson(json.decode(str));

String newUserModelToJson(NewUserModel data) => json.encode(data.toJson());

class NewUserModel {
    Data data;
    String message;

    NewUserModel({
        required this.data,
        required this.message,
    });

    factory NewUserModel.fromJson(Map<String, dynamic> json) => NewUserModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Userdetail userdetail;
    BusinessDetail businessDetail;

    Data({
        required this.userdetail,
        required this.businessDetail,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userdetail: Userdetail.fromJson(json["userdetail"]),
        businessDetail: BusinessDetail.fromJson(json["business_detail"]),
    );

    Map<String, dynamic> toJson() => {
        "userdetail": userdetail.toJson(),
        "business_detail": businessDetail.toJson(),
    };
}

class BusinessDetail {
    List<Profile> profile;

    BusinessDetail({
        required this.profile,
    });

    factory BusinessDetail.fromJson(Map<String, dynamic> json) => BusinessDetail(
        profile: List<Profile>.from(json["profile"].map((x) => Profile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "profile": List<dynamic>.from(profile.map((x) => x.toJson())),
    };
}

class Profile {
    String? id;
    String? rcNumber;
    String? companyName;
    dynamic? companyStatus;
    String? userId;
    dynamic? companyType;
    int? verificationStatus;
    List<Customer>? customer;
    List<Supplier>? suppliers;
    List<Sale>? sales;
    List<Staff>? staff;
    List<dynamic>? account;

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
        id: json["id"]??'',
        rcNumber: json["rc_number"]??'',
        companyName: json["company_name"]??'',
        companyStatus: json["company_status"]??'',
        userId: json["user_id"]??'',
        companyType: json["company_type"]??'',
        verificationStatus: json["verification_status"]??'',
        customer: List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x))),
        suppliers: List<Supplier>.from(json["suppliers"].map((x) => Supplier.fromJson(x))),
        sales: List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
        staff: List<Staff>.from(json["staff"].map((x) => Staff.fromJson(x))),
        account: List<dynamic>.from(json["account"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rc_number": rcNumber,
        "company_name": companyName,
        "company_status": companyStatus,
        "user_id": userId,
        "company_type": companyType,
        "verification_status": verificationStatus,
        "customer": List<dynamic>.from(customer!.map((x) => x.toJson())),
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x.toJson())),
        "sales": List<dynamic>.from(sales!.map((x) => x.toJson())),
        "staff": List<dynamic>.from(staff!.map((x) => x.toJson())),
        "account": List<dynamic>.from(account!.map((x) => x)),
    };
}

class Customer {
    String id;
    String fullname;
    String phoneNumber;
    String email;
    String country;
    String state;
    String city;
    String address;
    List<dynamic> transactions;

    Customer({
        required this.id,
        required this.fullname,
        required this.phoneNumber,
        required this.email,
        required this.country,
        required this.state,
        required this.city,
        required this.address,
        required this.transactions,
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
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
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
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
    };
}

class Sale {
    String id;
    String customerId;
    String customerName;
    String companyId;
    String salesAmount;
    String amountPaid;
    String paymentStatus;
    DateTime salesDate;
    String salesDescription;
    String createdBy;

    Sale({
        required this.id,
        required this.customerId,
        required this.customerName,
        required this.companyId,
        required this.salesAmount,
        required this.amountPaid,
        required this.paymentStatus,
        required this.salesDate,
        required this.salesDescription,
        required this.createdBy,
    });

    factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        companyId: json["company_id"],
        salesAmount: json["sales_amount"],
        amountPaid: json["amount_paid"],
        paymentStatus: json["payment_status"],
        salesDate: DateTime.parse(json["sales_date"]),
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
        "sales_date": "${salesDate.year.toString().padLeft(4, '0')}-${salesDate.month.toString().padLeft(2, '0')}-${salesDate.day.toString().padLeft(2, '0')}",
        "sales_description": salesDescription,
        "created_by": createdBy,
    };
}

class Staff {
    String id;
    String userId;
    String staffName;
    String companyId;
    String permission;

    Staff({
        required this.id,
        required this.userId,
        required this.staffName,
        required this.companyId,
        required this.permission,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        id: json["id"],
        userId: json["user_id"],
        staffName: json["staff_name"],
        companyId: json["company_id"],
        permission: json["permission"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "staff_name": staffName,
        "company_id": companyId,
        "permission": permission,
    };
}

class Supplier {
    String id;
    int bankCode;
    String accountNumber;
    String accountName;
    String name;
    String email;
    String phone;
    String country;
    String state;
    String city;
    String address;
    String companyId;

    Supplier({
        required this.id,
        required this.bankCode,
        required this.accountNumber,
        required this.accountName,
        required this.name,
        required this.email,
        required this.phone,
        required this.country,
        required this.state,
        required this.city,
        required this.address,
        required this.companyId,
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

class Userdetail {
    String id;
    String firstName;
    dynamic middleName;
    String lastName;
    String email;
    dynamic gender;
    String phoneNumber;
    dynamic dateOfBirth;
    dynamic phoneVerifiedAt;
    int bvnVerified;
    String identifier;
    String bvnId;
    int kycVerified;
    dynamic emailVerifiedAt;
    String referalCode;
    String referalBy;
    int recoveryMode;
    int loginAttempt;
    String passcode;
    String deviceId;
    String ipaddress;
    int isRestricted;
    String isDissabled;
    DateTime lastLogin;
    int hasGovernmentIdentity;
    int accountType;
    DateTime createdAt;
    DateTime updatedAt;
    int balanceDisplayMode;
    Nextofkin nextofkin;
    NewAccountDetailsModel accountdetail;
    List<Transaction> transactions;

    Userdetail({
        required this.id,
        required this.firstName,
        this.middleName,
        required this.lastName,
        required this.email,
        this.gender,
        required this.phoneNumber,
        this.dateOfBirth,
        this.phoneVerifiedAt,
        required this.bvnVerified,
        required this.identifier,
        required this.bvnId,
        required this.kycVerified,
        this.emailVerifiedAt,
        required this.referalCode,
        required this.referalBy,
        required this.recoveryMode,
        required this.loginAttempt,
        required this.passcode,
        required this.deviceId,
        required this.ipaddress,
        required this.isRestricted,
        required this.isDissabled,
        required this.lastLogin,
        required this.hasGovernmentIdentity,
        required this.accountType,
        required this.createdAt,
        required this.updatedAt,
        required this.balanceDisplayMode,
        required this.nextofkin,
        required this.accountdetail,
        required this.transactions,
    });

    factory Userdetail.fromJson(Map<String, dynamic> json) => Userdetail(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        dateOfBirth: json["date_of_birth"],
        phoneVerifiedAt: json["phone_verified_at"],
        bvnVerified: json["bvn_verified"],
        identifier: json["identifier"],
        bvnId: json["bvn_id"],
        kycVerified: json["kyc_verified"],
        emailVerifiedAt: json["email_verified_at"],
        referalCode: json["referal_code"],
        referalBy: json["referal_by"],
        recoveryMode: json["recovery_mode"],
        loginAttempt: json["login_attempt"],
        passcode: json["passcode"],
        deviceId: json["device_id"],
        ipaddress: json["ipaddress"],
        isRestricted: json["is_restricted"],
        isDissabled: json["is_dissabled"],
        lastLogin: DateTime.parse(json["last_login"]),
        hasGovernmentIdentity: json["has_government_identity"],
        accountType: json["account_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        balanceDisplayMode: json["balance_display_mode"],
        nextofkin: Nextofkin.fromJson(json["nextofkin"]),
        accountdetail: NewAccountDetailsModel.fromJson(json["accountdetail"]),
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
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
        "phone_verified_at": phoneVerifiedAt,
        "bvn_verified": bvnVerified,
        "identifier": identifier,
        "bvn_id": bvnId,
        "kyc_verified": kycVerified,
        "email_verified_at": emailVerifiedAt,
        "referal_code": referalCode,
        "referal_by": referalBy,
        "recovery_mode": recoveryMode,
        "login_attempt": loginAttempt,
        "passcode": passcode,
        "device_id": deviceId,
        "ipaddress": ipaddress,
        "is_restricted": isRestricted,
        "is_dissabled": isDissabled,
        "last_login": lastLogin.toIso8601String(),
        "has_government_identity": hasGovernmentIdentity,
        "account_type": accountType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "balance_display_mode": balanceDisplayMode,
        "nextofkin": nextofkin.toJson(),
        "accountdetail": accountdetail.toJson(),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    };
}

class NewAccountDetailsModel {
    String? id;
    String? accountNumber;
    String? accountName;
    String? bankName;
    String? accountType;
    String? status;
    String? currency;
    dynamic? manager;
    int? balance;

    NewAccountDetailsModel({
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

    factory NewAccountDetailsModel.fromJson(Map<String, dynamic> json) => NewAccountDetailsModel(
        id: json["id"]??'',
        accountNumber: json["account_number"]??'',
        accountName: json["account_name"]??'',
        bankName: json["bank_name"]??'',
        accountType: json["account_type"]??'',
        status: json["status"]??'',
        currency: json["currency"]??'',
        manager: json["manager"]??'',
        balance: json["balance"]??'',
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
    String id;
    String userId;
    String fullName;
    String bussinessId;
    String email;
    String phoneNumber;
    String houseAddress;
    String relationship;

    Nextofkin({
        required this.id,
        required this.userId,
        required this.fullName,
        required this.bussinessId,
        required this.email,
        required this.phoneNumber,
        required this.houseAddress,
        required this.relationship,
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

class Transaction {
    String id;
    String userId;
    String sessionId;
    String reference;
    dynamic transferId;
    String category;
    int inflow;
    int outflow;
    String tag;
    int chargesFee;
    TransactionType transactionType;
    TransactionStatus transactionStatus;
    dynamic completeMessage;
    int balanceBefore;
    int balanceAfter;
    String description;
    String toFrom;
    DateTime transactionDate;

    Transaction({
        required this.id,
        required this.userId,
        required this.sessionId,
        required this.reference,
        this.transferId,
        required this.category,
        required this.inflow,
        required this.outflow,
        required this.tag,
        required this.chargesFee,
        required this.transactionType,
        required this.transactionStatus,
        this.completeMessage,
        required this.balanceBefore,
        required this.balanceAfter,
        required this.description,
        required this.toFrom,
        required this.transactionDate,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        sessionId: json["session_id"],
        reference: json["reference"],
        transferId: json["transfer_id"],
        category: json["category"],
        inflow: json["inflow"],
        outflow: json["outflow"],
        tag: json["tag"],
        chargesFee: json["charges_fee"],
        transactionType: transactionTypeValues.map[json["transaction_type"]]!,
        transactionStatus: transactionStatusValues.map[json["transaction_status"]]!,
        completeMessage: json["complete_message"],
        balanceBefore: json["balance_before"],
        balanceAfter: json["balance_after"],
        description: json["description"],
        toFrom: json["to_from"],
        transactionDate: DateTime.parse(json["transaction_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "session_id": sessionId,
        "reference": reference,
        "transfer_id": transferId,
        "category": category,
        "inflow": inflow,
        "outflow": outflow,
        "tag": tag,
        "charges_fee": chargesFee,
        "transaction_type": transactionTypeValues.reverse[transactionType],
        "transaction_status": transactionStatusValues.reverse[transactionStatus],
        "complete_message": completeMessage,
        "balance_before": balanceBefore,
        "balance_after": balanceAfter,
        "description": description,
        "to_from": toFrom,
        "transaction_date": transactionDate.toIso8601String(),
    };
}

enum TransactionStatus { SUCCESS, PENDING }

final transactionStatusValues = EnumValues({
    "pending": TransactionStatus.PENDING,
    "success": TransactionStatus.SUCCESS
});

enum TransactionType { DEBIT, CREDIT }

final transactionTypeValues = EnumValues({
    "credit": TransactionType.CREDIT,
    "debit": TransactionType.DEBIT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
