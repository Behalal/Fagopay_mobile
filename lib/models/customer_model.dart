// ignore_for_file: public_member_api_docs, sort_constructors_first
class Customer {
  String? id;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? countryId;
  String? stateId;
  String? cityId;
  String? address;
  String? companyId;
  String? createdAt;
  String? updatedAt;

  Customer({
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
  });

  static Customer fromJson(json) => Customer(
        id: json['id'] as String?,
        fullname: json['fullname'] as String?,
        phoneNumber: json['phone_number'] as String?,
        email: json['email'] as String?,
        countryId: json['country_id'] as String?,
        stateId: json['state_id'] as String?,
        cityId: json['city_id'] as String?,
        address: json['address'] as String?,
        companyId: json['company_id'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  @override
  String toString() {
    return 'Customer(id: $id, fullname: $fullname, phoneNumber: $phoneNumber, email: $email, countryId: $countryId, stateId: $stateId, cityId: $cityId, address: $address, companyId: $companyId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
