// To parse this JSON data, do
//
//     final transactionList = transactionListFromJson(jsonString);

import 'dart:convert';

TransactionList transactionListFromJson(String str) =>
    TransactionList.fromJson(json.decode(str));

String transactionListToJson(TransactionList data) =>
    json.encode(data.toJson());

class TransactionList {
  TransactionList({
    required this.data,
    required this.message,
  });

  Data data;
  String message;

  factory TransactionList.fromJson(Map<String, dynamic> json) =>
      TransactionList(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.transactions,
    required this.accountDetails,
  });

  List<TransactionHistoryModel> transactions;
  AccountDetails accountDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<TransactionHistoryModel>.from(json["transactions"]
            .map((x) => TransactionHistoryModel.fromJson(x))),
        accountDetails: AccountDetails.fromJson(json["account_details"]),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "account_details": accountDetails.toJson(),
      };
}

class AccountDetails {
  AccountDetails({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.status,
    required this.currency,
    required this.balance,
  });

  String accountNumber;
  String accountName;
  String bankName;
  String status;
  String currency;
  int balance;

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        status: json["status"],
        currency: json["currency"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_name": bankName,
        "status": status,
        "currency": currency,
        "balance": balance,
      };
}

class TransactionHistoryModel {
  TransactionHistoryModel({
    this.id,
    this.userId,
    this.sessionId,
    this.reference,
    this.category,
    this.inflow,
    this.outflow,
    this.balanceBefore,
    this.balanceAfter,
    this.chargesFee,
    this.transactionType,
    this.transactionStatus,
    this.description,
    this.tag,
    this.toFrom,
    required this.createdAt,
    required this.updatedAt,
    this.meta,
  });

  String? id;
  String? userId;
  String? sessionId;
  String? reference;
  Category? category;
  int? inflow;
  int? outflow;
  int? balanceBefore;
  int? balanceAfter;
  int? chargesFee;
  TransactionType? transactionType;
  TransactionStatus? transactionStatus;
  String? description;
  Tag? tag;
  String? toFrom;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic meta;

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryModel(
        id: json["id"] ?? '',
        userId: json["user_id"] ?? '',
        sessionId: json["session_id"] ?? '',
        reference: json["reference"] ?? '',
        category: categoryValues.map[json["category"]]!,
        inflow: json["inflow"] ?? '',
        outflow: json["outflow"] ?? '',
        balanceBefore: json["balance_before"] ?? '',
        balanceAfter: json["balance_after"] ?? '',
        chargesFee: json["charges_fee"] ?? '',
        transactionType: transactionTypeValues.map[json["transaction_type"]]!,
        transactionStatus:
            transactionStatusValues.map[json["transaction_status"]]!,
        description: json["description"] ?? '',
        tag: tagValues.map[json["tag"]]!,
        toFrom: json["to_from"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
        meta: json["meta"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "session_id": sessionId,
        "reference": reference,
        "category": categoryValues.reverse[category],
        "inflow": inflow,
        "outflow": outflow,
        "balance_before": balanceBefore,
        "balance_after": balanceAfter,
        "charges_fee": chargesFee,
        "transaction_type": transactionTypeValues.reverse[transactionType],
        "transaction_status":
            transactionStatusValues.reverse[transactionStatus],
        "description": description,
        "tag": tagValues.reverse[tag],
        "to_from": toFrom,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "meta": meta,
      };
}

enum Category {
  PHONE_INTERNET,
  P2_P_TRANSFER,
  AIRTIME_RECHARGE_REVERSED,
  ELECTRICITY,
  CABLE,
  FUNDWALLET,
  INTERNET_ISP,
  REQUEST
}

final categoryValues = EnumValues({
  "Airtime Recharge - Reversed": Category.AIRTIME_RECHARGE_REVERSED,
  "Cable": Category.CABLE,
  "Electricity": Category.ELECTRICITY,
  "fundwallet": Category.FUNDWALLET,
  "Internet & ISP": Category.INTERNET_ISP,
  "P2P Transfer": Category.P2_P_TRANSFER,
  "Phone & Internet": Category.PHONE_INTERNET,
  "Request": Category.REQUEST
});

enum Tag {
  AIRTIME_RECHARGE,
  TRANSFER,
  AIRTIME_RECHARGE_REVERSED,
  DATA_BUNDLE,
  POWER,
  CABLE,
  FUNDS_RECIEVE,
  REQUEST
}

final tagValues = EnumValues({
  "Airtime Recharge": Tag.AIRTIME_RECHARGE,
  "Airtime Recharge - Reversed": Tag.AIRTIME_RECHARGE_REVERSED,
  "Cable": Tag.CABLE,
  "Data Bundle": Tag.DATA_BUNDLE,
  "Funds Recieve": Tag.FUNDS_RECIEVE,
  "Power": Tag.POWER,
  "Request": Tag.REQUEST,
  "Transfer": Tag.TRANSFER
});

enum TransactionStatus { SUCCESS }

final transactionStatusValues =
    EnumValues({"success": TransactionStatus.SUCCESS});

enum TransactionType { DEBIT, CREDIT }

final transactionTypeValues = EnumValues(
    {"credit": TransactionType.CREDIT, "debit": TransactionType.DEBIT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
