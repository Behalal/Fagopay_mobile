// ignore_for_file: public_member_api_docs, sort_constructors_first
class Supplier {
  String? id;
  int? bankCode;
  String? accountNumber;
  String? accountName;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? countryId;
  String? stateId;
  String? cityId;
  String? companyId;
  String? updatedAt;
  String? createdAt;

  Supplier({
    this.id,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.countryId,
    this.stateId,
    this.cityId,
    this.companyId,
    this.updatedAt,
    this.createdAt,
  });

  static Supplier fromJson(json) => Supplier(
        id: json['id'] as String?,
        bankCode: json['bank_code'] as int?,
        accountNumber: json['account_number'] as String?,
        accountName: json['account_name'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        countryId: json['country_id'] as String?,
        stateId: json['state_id'] as String?,
        cityId: json['city_id'] as String?,
        companyId: json['company_id'] as String?,
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
      );

  @override
  String toString() {
    return 'Supplier(id: $id, bankCode: $bankCode, accountNumber: $accountNumber, accountName: $accountName, name: $name, email: $email, phone: $phone, address: $address, countryId: $countryId, stateId: $stateId, cityId: $cityId, companyId: $companyId, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}
