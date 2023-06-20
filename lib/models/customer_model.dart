
class Customer {
  String? id;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? country;
  String? state;
  String? city;
  String? address;
  List<Map<String, String?>>? transactions;
  Company? company;

  Customer({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.country,
    this.state,
    this.city,
    this.address,
    this.transactions,
    this.company,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    fullname: json["fullname"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    transactions: json["transactions"] == null ? [] : List<Map<String, String?>>.from(json["transactions"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone_number": phoneNumber,
    "email": email,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "company": company?.toJson(),
  };
}

class Company {
  String? id;
  String? companyName;

  Company({
    this.id,
    this.companyName,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
  };
}
