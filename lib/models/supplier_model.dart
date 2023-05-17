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
  String? country;
  String? state;
  String? city;
  String? companyId;
  // String? updatedAt;
  // String? createdAt;

  Supplier({
    this.id,
    this.bankCode,
    this.accountNumber,
    this.accountName,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.country,
    this.state,
    this.city,
    this.companyId,
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
        country: json['country'] as String?,
        state: json['state'] as String?,
        city: json['city'] as String?,
        companyId: json['company_id'] as String?,
        // updatedAt: json['updated_at'] as String?,
        // createdAt: json['created_at'] as String?,
      );

  @override
  String toString() {
    return 'Supplier(id: $id, bankCode: $bankCode, accountNumber: $accountNumber, accountName: $accountName, name: $name, email: $email, phone: $phone, address: $address, country: $country, state: $state, city: $city, companyId: $companyId)';
  }
}
