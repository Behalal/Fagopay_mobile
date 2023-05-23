// ignore_for_file: public_member_api_docs, sort_constructors_first

class Invoice {
  String? id;
  String? invoiceNo;
  Map<String, dynamic>? customer;
  Map<String, dynamic>? company;
  String? status;
  String? total;
  String? subtotal;
  String? amountPaid;
  String? transactionId;
  String? paymentMode;
  String? discountRate;
  String? discountAmount;
  String? taxRate;
  String? taxAmount;
  String? markAsPaidBy;
  String? paidOn;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  List<InvoiceDetail>? invoiceDetails;

  Invoice({
    this.id,
    this.invoiceNo,
    this.customer,
    this.company,
    this.status,
    this.total,
    this.subtotal,
    this.amountPaid,
    this.transactionId,
    this.paymentMode,
    this.discountRate,
    this.discountAmount,
    this.taxRate,
    this.taxAmount,
    this.markAsPaidBy,
    this.paidOn,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.invoiceDetails,
  });

  static Invoice fromJson(json) => Invoice(
        id: json['id'] as String?,
        invoiceNo: json['invoice_no'] as String?,
        customer: json['customer'] as dynamic,
        company: json['company'] as dynamic,
        status: json['status'] as String?,
        total: json['total'] as String?,
        subtotal: json['subtotal'] as String?,
        amountPaid: json['amount_paid'] as String?,
        transactionId: json['transaction_id'] as String?,
        paymentMode: json['payment_mode'] as String?,
        discountRate: json['discount_rate'] as String?,
        discountAmount: json['discount_amount'] as String?,
        taxRate: json['tax_rate'] as String?,
        taxAmount: json['tax_amount'] as String?,
        markAsPaidBy: json['mark_as_paid_by'] as String?,
        paidOn: json['paid_on'] as String?,
        createdBy: json['created_by'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        invoiceDetails: json['invoice_detail']
            .map<InvoiceDetail>(InvoiceDetail.fromJson)
            .toList() as List<InvoiceDetail>?,
      );

  @override
  String toString() {
    return 'Invoice(id: $id, invoiceNo: $invoiceNo, customer: $customer, company: $company, status: $status, total: $total, subtotal: $subtotal, amountPaid: $amountPaid, transactionId: $transactionId, paymentMode: $paymentMode, discountRate: $discountRate, discountAmount: $discountAmount, taxRate: $taxRate, taxAmount: $taxAmount, markAsPaidBy: $markAsPaidBy, paidOn: $paidOn, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, invoiceDetails: $invoiceDetails)';
  }
}

class InvoiceDetail {
  String? id;
  String? invoiceId;
  String? itemName;
  int? quantity;
  String? price;
  String? subTotal;
  String? total;
  String? description;
  String? discountRate;
  String? discountAmount;
  String? taxRate;
  String? taxAmount;
  String? createdAt;
  String? updatedAt;

  InvoiceDetail({
    this.id,
    this.invoiceId,
    this.itemName,
    this.quantity,
    this.price,
    this.subTotal,
    this.total,
    this.description,
    this.discountRate,
    this.discountAmount,
    this.taxRate,
    this.taxAmount,
    this.createdAt,
    this.updatedAt,
  });

  static InvoiceDetail fromJson(json) => InvoiceDetail(
        id: json['id'] as String?,
        invoiceId: json['invoice_id'] as String?,
        itemName: json['itemname'] as String?,
        quantity: json['quantity'] as int?,
        price: json['price'] as String?,
        subTotal: json['sub_total'] as String?,
        total: json['total'] as String?,
        description: json['description'] as String?,
        discountRate: json['discount_rate'] as String?,
        discountAmount: json['discount_amount'] as String?,
        taxRate: json['tax_rate'] as String?,
        taxAmount: json['tax_amount'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  @override
  String toString() {
    return 'InvoiceDetail(id: $id, invoiceId: $invoiceId, itemName: $itemName, quantity: $quantity, price: $price, subTotal: $subTotal, total: $total, description: $description, discountRate: $discountRate, discountAmount: $discountAmount, taxRate: $taxRate, taxAmount: $taxAmount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
