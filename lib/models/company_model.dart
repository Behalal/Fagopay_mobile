// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fagopay/models/user_model/user.dart';

class Company {
  String? id;
  String? rcNumber;
  String? companyName;
  String? companyStatus;
  int? isVerified;
  String? userId;
  String? companyType;
  AccountDetail? accountDetails;
  // List<Customer>? customers;
  // List<Supplier>? suppliers;
  // List<Sales>? sales;

  Company({
    // this.customers,
    // this.suppliers,
    // this.sales,
    this.id,
    this.rcNumber,
    this.companyName,
    this.companyStatus,
    this.isVerified,
    this.userId,
    this.companyType,
    this.accountDetails,
  });

  static Company fromJson(json) => Company(
        id: json['id'] as String?,
        rcNumber: json['rc_number'] as String?,
        companyName: json['company_name'] as String?,
        companyStatus: json['company_status'] as String?,
        isVerified: json['verification_status'] as int?,
        userId: json['user_id'] as String?,
        companyType: json['company_type'] as String?,
        accountDetails: AccountDetail.fromJson(json['account']),
        // customers: json['customer'].map<Customer>(Customer.fromJson).toList()
        //     as List<Customer>?,
        // suppliers: json['suppliers'].map<Supplier>(Supplier.fromJson).toList()
        //     as List<Supplier>?,
        // sales:
        //     json['sales'].map<Sales>(Sales.fromJson).toList() as List<Sales>?,
      );

  @override
  String toString() {
    return 'Company(id: $id, rcNumber: $rcNumber, companyName: $companyName, companyStatus: $companyStatus, isVerified: $isVerified, userId: $userId, companyType: $companyType)';
  }

  toMap() {}

  static fromMap(Map<String, dynamic> map) {}
}
