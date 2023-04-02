// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  User? userdetail;
  AccountDetail? accountdetail;

  UserModel({
    this.userdetail,
    this.accountdetail,
  });

  static UserModel fromJson(json) => UserModel(
        userdetail: json['userdetail'] as User?,
        accountdetail: json['accountdetail'] as AccountDetail?,
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
  String? emailVerifiedAt;
  String? recoveryMode;
  String? ipAddress;
  String? bvnId;
  int? kycVerified;
  String? deviceId;

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
    this.emailVerifiedAt,
    this.recoveryMode,
    this.ipAddress,
    this.bvnId,
    this.kycVerified,
    this.deviceId,
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
        referralCode: json['referal_code'] as String?,
        referralBy: json['referal_by'] as String?,
        ipAddress: json['ipaddress'] as String?,
      );
}

class AccountDetail {
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? status;
  String? currency;
  int? balance;

  AccountDetail({
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.accountType,
    this.status,
    this.currency,
    this.balance,
  });

  static AccountDetail fromJson(json) => AccountDetail(
        accountNumber: json['account_number'] as String?,
        accountName: json['account_name'] as String?,
        bankName: json['bank_name'] as String?,
        accountType: json['account_type'] as String?,
        status: json['status'] as String?,
        currency: json['currency'] as String?,
        balance: json['balance'] as int?,
      );
}
