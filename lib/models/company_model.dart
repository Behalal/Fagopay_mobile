// ignore_for_file: public_member_api_docs, sort_constructors_first
class Company {
  String? id;
  String? rcNumber;
  String? companyName;
  String? emailAddress;
  String? branchAddress;
  String? state;
  String? country;
  String? city;
  String? address;
  String? companyStatus;
  String? lga;
  String? dateOfRegistration;
  int? otpVerified;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Company({
    this.id,
    this.rcNumber,
    this.companyName,
    this.emailAddress,
    this.branchAddress,
    this.state,
    this.country,
    this.city,
    this.address,
    this.companyStatus,
    this.lga,
    this.dateOfRegistration,
    this.otpVerified,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  static Company fromJson(json) => Company(
        id: json['id'] as String?,
        rcNumber: json['rc_number'] as String?,
        companyName: json['company_name'] as String?,
        emailAddress: json['email_address'] as String?,
        branchAddress: json['branchAddress'] as String?,
        state: json['state'] as String?,
        country: json['country'] as String?,
        city: json['city'] as String?,
        address: json['address'] as String?,
        companyStatus: json['company_status'] as String?,
        lga: json['lga'] as String?,
        dateOfRegistration: json['date_of_registration'] as String?,
        otpVerified: json['otp_verified'] as int?,
        userId: json['user_id'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as String?,
      );

  @override
  String toString() {
    return 'Company(id: $id, rcNumber: $rcNumber, companyName: $companyName, emailAddress: $emailAddress, branchAddress: $branchAddress, state: $state, country: $country, city: $city, address: $address, companyStatus: $companyStatus, lga: $lga, dateOfRegistration: $dateOfRegistration, otpVerified: $otpVerified, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
