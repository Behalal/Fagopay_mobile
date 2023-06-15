// To parse this JSON data, do
//
//     final txFilterModel = txFilterModelFromJson(jsonString);

import 'dart:convert';

TxFilterModel txFilterModelFromJson(String str) => TxFilterModel.fromJson(json.decode(str));

String txFilterModelToJson(TxFilterModel data) => json.encode(data.toJson());

class TxFilterModel {
  Data data;
  String message;

  TxFilterModel({
    required this.data,
    required this.message,
  });

  factory TxFilterModel.fromJson(Map<String, dynamic> json) => TxFilterModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  List<TransactionFilter> transactionFilter;

  Data({
    required this.transactionFilter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transactionFilter: List<TransactionFilter>.from(json["transaction_filter"].map((x) => TransactionFilter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transaction_filter": List<dynamic>.from(transactionFilter.map((x) => x.toJson())),
  };
}

class TransactionFilter {
  String id;
  String name;

  TransactionFilter({
    required this.id,
    required this.name,
  });

  factory TransactionFilter.fromJson(Map<String, dynamic> json) => TransactionFilter(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
