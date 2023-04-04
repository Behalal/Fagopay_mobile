// ignore_for_file: public_member_api_docs, sort_constructors_first

class BankDetails {
  int? id;
  String? bankCode;
  String? bankName;

  BankDetails({
    this.id,
    this.bankCode,
    this.bankName,
  });

  static BankDetails fromJson(json) => BankDetails(
        id: json['id'] as int?,
        bankCode: json['code'] as String?,
        bankName: json['name'] as String?,
      );

  @override
  String toString() =>
      'BankDetails(id: $id, bankCode: $bankCode, bankName: $bankName)';
}
