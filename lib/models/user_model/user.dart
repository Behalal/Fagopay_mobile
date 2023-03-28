import 'dart:convert';
import 'dart:developer';

class User {
  int? code;
  String? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? identifier;
  String? referralCode;
  String? referralBy;
  String? bvnId;
  String? nextOfKin;
  int? accountType;
  int? kycVerified;
  String? deviceId;
  String? message;
  dynamic accountDetails;

  User(
      {this.code,
      this.id,
      this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.gender,
      this.dateOfBirth,
      this.identifier,
      this.referralCode,
      this.referralBy,
      this.bvnId,
      this.nextOfKin,
      this.accountType,
      this.kycVerified,
      this.deviceId,
      this.message,
      this.accountDetails});

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var data = json['body']['data'];
    var message = json['message'];
    var userdetails = (data != null) ? data['userdetail'] : null;

    return User(
      code: json['status_code'],
      id: (userdetails != null) ? userdetails['id'] : null,
      email: (userdetails != null) ? userdetails['email'] : null,
      firstName: (userdetails != null) ? userdetails['first_name'] : null,
      phone: (userdetails != null) ? userdetails['firstname'] : null,
      gender: (userdetails != null) ? userdetails['gender'] : null,
      dateOfBirth: (userdetails != null) ? userdetails['date_of_birth'] : null,
      identifier: (userdetails != null) ? userdetails['identifier'] : null,
      referralCode: (userdetails != null) ? userdetails['referal_code'] : null,
      referralBy: (userdetails != null) ? userdetails['referal_by'] : null,
      bvnId: (userdetails != null) ? userdetails['bvn_id'] : null,
      nextOfKin: (userdetails != null) ? userdetails['nextofkin'] : null,
      accountType: (userdetails != null) ? userdetails['account_type'] : null,
      kycVerified: (userdetails != null) ? userdetails['kyc_verified'] : null,
      deviceId: (userdetails != null) ? userdetails['device_id'] : null,
      message: (message != null) ? message : null,
      accountDetails: (data != null) ? data['accountdetail'] : null,
    );
  }

  void printAttributes() {
    log("code: $code\n");
    log("id: $id\n");
    log("email: $email\n");
    log("phone: $phone\n");
    log("name: $firstName\n");
    log("lastname: $lastName\n");
    log("firstname: $firstName\n");
    log("dateofBirth: $dateOfBirth\n");
    log("identifier: $identifier\n");
    log("referralCode: $referralCode\n");
    log("referralBy: $referralBy\n");
    log("bvnId: $bvnId\n");
    log("nextOfKin: $nextOfKin\n");
    log("accountType: $accountType\n");
    log("kycVerified: $kycVerified\n");
    log("deviceId: $deviceId\n");
    log("gender: $gender\n");
    log("accountDetails: $accountDetails\n");
  }
}

User userFullDetails = User();
