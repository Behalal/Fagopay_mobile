// ignore_for_file: public_member_api_docs, sort_constructors_first

class Sales {
  String? id;
  String? companyId;
  String? customerId;
  String? customerName;
  String? salesAmount;
  String? amountPaid;
  String? paymentStatus;
  String? salesDate;
  String? salesDescription;
  // String? transactionId;
  String? createdBy;
  // String? createdAt;
  // String? updatedAt;
  // Company? companyDetails;
  // Customer? customerDetails;

  Sales({
    this.id,
    this.companyId,
    this.customerId,
    this.customerName,
    this.salesAmount,
    this.amountPaid,
    this.paymentStatus,
    this.salesDate,
    this.salesDescription,
    this.createdBy,
  });

  static Sales fromJson(json) => Sales(
        id: json['id'] as String?,
        companyId: json['company_id'] as String?,
        customerId: json['customer_id'] as String?,
        customerName: json['customer_name'] as String?,
        salesAmount: json['sales_amount'] as String?,
        amountPaid: json['amount_paid'] as String?,
        paymentStatus: json['payment_status'] as String?,
        salesDate: json['sales_date'] as String?,
        salesDescription: json['sales_description'] as String?,
        // transactionId: json['transaction_id'] as String?,
        createdBy: json['created_by'] as String?,
        // createdAt: json['created_at'] as String?,
        // updatedAt: json['updated_at'] as String?,
        // companyDetails: Company.fromJson(json['company']),
        // customerDetails: Customer.fromJson(json['customer']),
      );

  @override
  String toString() {
    return 'Sales(id: $id, companyId: $companyId, customerId: $customerId, customerName: $customerName, salesAmount: $salesAmount, amountPaid: $amountPaid, paymentStatus: $paymentStatus, salesDate: $salesDate, salesDescription: $salesDescription, createdBy: $createdBy)';
  }
}
