// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  User? userdetail;
  AccountDetail? accountdetail;

  UserModel({
    this.userdetail,
    this.accountdetail,
  });

  static UserModel fromJson(json) => UserModel(
        userdetail: User.fromJson(json['userdetail']),
        accountdetail: AccountDetail.fromJson(json['accountdetail']),
      );
}

class User {
  String? id;
  String? email;
  String? phone;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? identifier;
  String? referralCode;
  String? referralBy;
  int? bvnVerified;
  int? accountType;
  String? emailVerifiedAt;
  String? recoveryMode;
  String? ipAddress;
  String? bvnId;
  int? kycVerified;
  String? deviceId;
  String? dailyLimts;
  int? hasGovernmentIdentity;
  Nextofkin? nextofkin;

  User({
    this.id,
    this.email,
    this.phone,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.identifier,
    this.referralCode,
    this.referralBy,
    this.bvnVerified,
    this.accountType,
    this.emailVerifiedAt,
    this.recoveryMode,
    this.ipAddress,
    this.bvnId,
    this.kycVerified,
    this.deviceId,
    this.dailyLimts,
    this.hasGovernmentIdentity,
    this.nextofkin,
  });

  static User fromJson(json) => User(
        id: json['id'] as String?,
        firstName: json['first_name'] as String?,
        middleName: json['middle_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        phone: json['phone_number'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        identifier: json['identifier'] as String?,
        bvnVerified: json['bvn_verified'] as int?,
        bvnId: json['bvn_id'] as String?,
        kycVerified: json['kyc_verified'] as int?,
        accountType: json['account_type'] as int?,
        referralCode: json['referal_code'] as String?,
        referralBy: json['referal_by'] as String?,
        ipAddress: json['ipaddress'] as String?,
        dailyLimts: json['account_daily_limit'] as String?,
        hasGovernmentIdentity: json['has_government_identity'] as int?,
        // nextofkin: Nextofkin.fromJson(json["nextofkin"] ?? ''),
      );

  @override
  String toString() {
    return 'User(id: $id, email: $email, phone: $phone, firstName: $firstName, middleName: $middleName, lastName: $lastName, gender: $gender, dateOfBirth: $dateOfBirth, identifier: $identifier, referralCode: $referralCode, referralBy: $referralBy, bvnVerified: $bvnVerified, accountType: $accountType, emailVerifiedAt: $emailVerifiedAt, recoveryMode: $recoveryMode, ipAddress: $ipAddress, bvnId: $bvnId, kycVerified: $kycVerified, deviceId: $deviceId, dailyLimts: $dailyLimts, nextofkin: $nextofkin)';
  }
}

class AccountDetail {
  String? id;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? status;
  String? currency;
  String? manager;
  dynamic balance;

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
        id: json["id"] as String,
        accountNumber: json["account_number"] as String?,
        accountName: json["account_name"] as String?,
        bankName: json["bank_name"] as String?,
        accountType: json["account_type"] as String?,
        status: json["status"] as String?,
        currency: json["currency"] as String?,
        manager: json["manager"] as String?,
        balance: json["balance"] as dynamic,
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

  @override
  String toString() {
    return 'AccountDetail(id: $id, accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, accountType: $accountType, status: $status, currency: $currency, manager: $manager, balance: $balance)';
  }
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
        id: json["id"] ?? '',
        userId: json["user_id"] ?? '',
        fullName: json["full_name"] ?? '',
        bussinessId: json["bussiness_id"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        houseAddress: json["house_address"] ?? '',
        relationship: json["relationship"] ?? '',
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
// class AccountDetail {
//   String? accountNumber;
//   String? accountName;
//   String? bankName;
//   String? accountType;
//   String? status;
//   String? currency;
//   int? balance;

//   AccountDetail({
//     this.accountNumber,
//     this.accountName,
//     this.bankName,
//     this.accountType,
//     this.status,
//     this.currency,
//     this.balance,
//   });

//   static AccountDetail fromJson(json) => AccountDetail(
//         accountNumber: json['account_number'] as String?,
//         accountName: json['account_name'] as String?,
//         bankName: json['bank_name'] as String?,
//         accountType: json['account_type'] as String?,
//         status: json['status'] as String?,
//         currency: json['currency'] as String?,
//         balance: json['balance'] as int?,
//       );
// }

