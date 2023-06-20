// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/models/company_model.dart';
import 'package:fagopay/models/customer_model.dart';

class Employee {
  String? id;
  String? permission;
  String? name;
  String? createdAt;
  Company? companyDetail;

  Employee({
    this.id,
    this.permission,
    this.name,
    this.createdAt,
    this.companyDetail,
  });

  static Employee fromJson(json) => Employee(
        id: json['id'] as String?,
        permission: json['permission'] as String?,
        name: json['name'] as String?,
        createdAt: json['created_at'] as String?,
        companyDetail: Company.fromJson(json['company_detail']),
      );

  @override
  String toString() {
    return 'Employee(id: $id, permission: $permission, name: $name, createdAt: $createdAt, companyDetail: $companyDetail)';
  }
}
