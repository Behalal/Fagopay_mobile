// ignore_for_file: public_member_api_docs, sort_constructors_first

class Company {
  String? id;
  String? rcNumber;
  String? companyName;
  int? otpVerified;
  int? isVerified;
  String? userId;
  // List<Customer>? customers;
  // List<Supplier>? suppliers;
  // List<Sales>? sales;

  Company({
    this.id,
    this.rcNumber,
    this.companyName,
    this.otpVerified,
    this.isVerified,
    this.userId,
    // this.customers,
    // this.suppliers,
    // this.sales,
  });

  static Company fromJson(json) => Company(
        id: json['id'] as String?,
        rcNumber: json['rc_number'] as String?,
        companyName: json['company_name'] as String?,
        otpVerified: json['otp_verified'] as int?,
        isVerified: json['is_verified'] as int?,
        userId: json['user_id'] as String?,
        // customers: json['customer'].map<Customer>(Customer.fromJson).toList()
        //     as List<Customer>?,
        // suppliers: json['suppliers'].map<Supplier>(Supplier.fromJson).toList()
        //     as List<Supplier>?,
        // sales:
        //     json['sales'].map<Sales>(Sales.fromJson).toList() as List<Sales>?,
      );

  @override
  String toString() {
    return 'Company(id: $id, rcNumber: $rcNumber, companyName: $companyName, otpVerified: $otpVerified, isVerified: $isVerified, userId: $userId)';
  }
}
