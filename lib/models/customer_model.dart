// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/models/company_model.dart';
import 'package:fagopay/models/sales_model.dart';

class Customer {
  String? id;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? country;
  String? state;
  String? city;
  String? address;
  Company? company;
  List<Sales>? transactions;

  Customer({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.country,
    this.state,
    this.city,
    this.address,
    this.company,
    this.transactions,
  });

  static Customer fromJson(json) => Customer(
        id: json['id'] as String?,
        fullname: json['fullname'] as String?,
        phoneNumber: json['phone_number'] as String?,
        email: json['email'] as String?,
        country: json['country'] as String?,
        state: json['state'] as String?,
        city: json['city'] as String?,
        address: json['address'] as String?,
        company: Company.fromJson(json['company']),
      );

  @override
  String toString() {
    return 'Customer(id: $id, fullname: $fullname, phoneNumber: $phoneNumber, email: $email, country: $country, state: $state, city: $city, address: $address, company: $company, transactions: $transactions)';
  }
}
