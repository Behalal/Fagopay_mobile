// To parse this JSON data, do
//
//     final completeUserModel = completeUserModelFromJson(jsonString);

import 'dart:convert';

CompleteUserModel completeUserModelFromJson(String str) => CompleteUserModel.fromJson(json.decode(str));

String completeUserModelToJson(CompleteUserModel data) => json.encode(data.toJson());

class CompleteUserModel {
    CompleteUserModel({
        required this.data,
        required this.message,
    });

    Data data;
    String message;

    factory CompleteUserModel.fromJson(Map<String, dynamic> json) => CompleteUserModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.userdetail,
        required this.accountdetail,
        required this.businessDetail,
    });

    Userdetail userdetail;
    Accountdetail accountdetail;
    BusinessDetail businessDetail;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userdetail: Userdetail.fromJson(json["userdetail"]),
        accountdetail: Accountdetail.fromJson(json["accountdetail"]),
        businessDetail: BusinessDetail.fromJson(json["business_detail"]),
    );

    Map<String, dynamic> toJson() => {
        "userdetail": userdetail.toJson(),
        "accountdetail": accountdetail.toJson(),
        "business_detail": businessDetail.toJson(),
    };
}

class Accountdetail {
    Accountdetail({
        required this.accountNumber,
        required this.accountName,
        required this.bankName,
        required this.accountType,
        required this.status,
        required this.currency,
        required this.balance,
    });

    String accountNumber;
    String accountName;
    String bankName;
    String accountType;
    String status;
    String currency;
    int balance;

    factory Accountdetail.fromJson(Map<String, dynamic> json) => Accountdetail(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        accountType: json["account_type"],
        status: json["status"],
        currency: json["currency"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_name": bankName,
        "account_type": accountType,
        "status": status,
        "currency": currency,
        "balance": balance,
    };
}

class BusinessDetail {
    BusinessDetail({
        required this.profile,
        required this.staff,
        required this.transactions,
        required this.suppliers,
    });

    Profile profile;
    List<dynamic> staff;
    List<dynamic> transactions;
    List<dynamic> suppliers;

    factory BusinessDetail.fromJson(Map<String, dynamic> json) => BusinessDetail(
        profile: Profile.fromJson(json["profile"]),
        staff: List<dynamic>.from(json["staff"].map((x) => x)),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "staff": List<dynamic>.from(staff.map((x) => x)),
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
        "suppliers": List<dynamic>.from(suppliers.map((x) => x)),
    };
}

class Profile {
    Profile({
        required this.id,
        required this.rcNumber,
        required this.companyName,
        required this.emailAddress,
        this.branchAddress,
        required this.state,
        required this.country,
        required this.city,
        required this.address,
        this.companyStatus,
        this.lga,
        this.dateOfRegistration,
        required this.otpVerified,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
        required this.employees,
        required this.suppliers,
    });

    String id;
    String rcNumber;
    String companyName;
    String emailAddress;
    dynamic branchAddress;
    String state;
    String country;
    String city;
    String address;
    dynamic companyStatus;
    dynamic lga;
    dynamic dateOfRegistration;
    int otpVerified;
    String userId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    List<dynamic> employees;
    List<dynamic> suppliers;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        rcNumber: json["rc_number"],
        companyName: json["company_name"],
        emailAddress: json["email_address"],
        branchAddress: json["branchAddress"],
        state: json["state"],
        country: json["country"],
        city: json["city"],
        address: json["address"],
        companyStatus: json["company_status"],
        lga: json["lga"],
        dateOfRegistration: json["date_of_registration"],
        otpVerified: json["otp_verified"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        employees: List<dynamic>.from(json["employees"].map((x) => x)),
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rc_number": rcNumber,
        "company_name": companyName,
        "email_address": emailAddress,
        "branchAddress": branchAddress,
        "state": state,
        "country": country,
        "city": city,
        "address": address,
        "company_status": companyStatus,
        "lga": lga,
        "date_of_registration": dateOfRegistration,
        "otp_verified": otpVerified,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "employees": List<dynamic>.from(employees.map((x) => x)),
        "suppliers": List<dynamic>.from(suppliers.map((x) => x)),
    };
}

class Userdetail {
    Userdetail({
        required this.id,
        required this.firstName,
        this.middleName,
        required this.lastName,
        required this.email,
        required this.gender,
        required this.phoneNumber,
        required this.dateOfBirth,
        required this.phoneVerifiedAt,
        required this.bvnVerified,
        required this.identifier,
        required this.bvnId,
        required this.kycVerified,
        this.emailVerifiedAt,
        this.referalCode,
        this.referalBy,
        required this.recoveryMode,
        required this.loginAttempt,
        required this.passcode,
        this.deviceId,
        required this.ipaddress,
        required this.isRestricted,
        required this.isDissabled,
        required this.lastLogin,
        required this.accountType,
        this.createdAt,
        required this.updatedAt,
        required this.balanceDisplayMode,
        required this.nextofkin,
    });

    String id;
    String firstName;
    dynamic middleName;
    String lastName;
    String email;
    String gender;
    String phoneNumber;
    DateTime dateOfBirth;
    DateTime phoneVerifiedAt;
    int bvnVerified;
    String identifier;
    String bvnId;
    int kycVerified;
    dynamic emailVerifiedAt;
    dynamic referalCode;
    dynamic referalBy;
    int recoveryMode;
    int loginAttempt;
    String passcode;
    dynamic deviceId;
    String ipaddress;
    int isRestricted;
    String isDissabled;
    DateTime lastLogin;
    int accountType;
    dynamic createdAt;
    DateTime updatedAt;
    int balanceDisplayMode;
    Nextofkin nextofkin;

    factory Userdetail.fromJson(Map<String, dynamic> json) => Userdetail(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
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
        accountType: json["account_type"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        balanceDisplayMode: json["balance_display_mode"],
        nextofkin: Nextofkin.fromJson(json["nextofkin"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "gender": gender,
        "phone_number": phoneNumber,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "phone_verified_at": phoneVerifiedAt.toIso8601String(),
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
        "account_type": accountType,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "balance_display_mode": balanceDisplayMode,
        "nextofkin": nextofkin.toJson(),
    };
}

class Nextofkin {
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

    String id;
    String userId;
    String fullName;
    String bussinessId;
    String email;
    String phoneNumber;
    String houseAddress;
    String relationship;

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
