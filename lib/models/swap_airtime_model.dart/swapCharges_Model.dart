// To parse this JSON data, do
//
//     final getCharges = getChargesFromJson(jsonString);

import 'dart:convert';

GetCharges getChargesFromJson(String str) => GetCharges.fromJson(json.decode(str));

String getChargesToJson(GetCharges data) => json.encode(data.toJson());

class GetCharges {
    Data data;
    String message;

    GetCharges({
        required this.data,
        required this.message,
    });

    factory GetCharges.fromJson(Map<String, dynamic> json) => GetCharges(
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    SwapCharges swapCharges;

    Data({
        required this.swapCharges,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        swapCharges: SwapCharges.fromJson(json["swap_charges"]),
    );

    Map<String, dynamic> toJson() => {
        "swap_charges": swapCharges.toJson(),
    };
}

class SwapCharges {
    String? network;
    int? fee;
    String? swappingAmount;

    SwapCharges({
         this.network,
         this.fee,
         this.swappingAmount,
    });

    factory SwapCharges.fromJson(Map<String, dynamic> json) => SwapCharges(
        network: json["network"]?? '',
        fee: json["fee"]??'',
        swappingAmount: json["swapping_amount"]??'',
    );

    Map<String, dynamic> toJson() => {
        "network": network,
        "fee": fee,
        "swapping_amount": swappingAmount,
    };
}
