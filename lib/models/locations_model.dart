// ignore_for_file: public_member_api_docs, sort_constructors_first
class Country {
  String? id;
  String? name;
  String? iso3;
  String? iso2;
  String? numericCode;
  String? phoneCode;
  String? capital;
  String? currency;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  int? active;

  Country({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.numericCode,
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
    this.active,
  });

  static Country fromJson(json) => Country(
        id: json['id'] as String?,
        name: json['name'] as String?,
        iso3: json['iso3'] as String?,
        iso2: json['iso2'] as String?,
        numericCode: json['numeric_code'] as String?,
        phoneCode: json['phone_code'] as String?,
        capital: json['capital'] as String?,
        currency: json['currency'] as String?,
        currencySymbol: json['currency_symbol'] as String?,
        tld: json['tld'] as String?,
        native: json['native'] as String?,
        region: json['region'] as String?,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        emoji: json['emoji'] as String?,
        emojiU: json['emojiU'] as String?,
        active: json['active'] as int?,
      );

  @override
  String toString() {
    return 'Country(id: $id, name: $name, iso3: $iso3, iso2: $iso2, numericCode: $numericCode, phoneCode: $phoneCode, capital: $capital, currency: $currency, currencySymbol: $currencySymbol, tld: $tld, native: $native, region: $region, latitude: $latitude, longitude: $longitude, emoji: $emoji, emojiU: $emojiU, active: $active)';
  }
}

class State {
  String? id;
  String? name;
  String? stateCode;
  String? latitude;
  String? longitude;
  String? type;

  State({
    this.id,
    this.name,
    this.stateCode,
    this.latitude,
    this.longitude,
    this.type,
  });

  static State fromJson(json) => State(
        id: json['id'] as String?,
        name: json['name'] as String?,
        stateCode: json['state_code'] as String?,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        type: json['type'] as String?,
      );

  @override
  String toString() {
    return 'State(id: $id, name: $name, stateCode: $stateCode, latitude: $latitude, longitude: $longitude, type: $type)';
  }
}

class City {
  String? id;
  String? name;
  String? latitude;
  String? longitude;
  String? countryId;
  String? stateId;
  String? createdAt;
  String? updatedAt;

  City({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.countryId,
    this.stateId,
    this.createdAt,
    this.updatedAt,
  });

  static City fromJson(json) => City(
        id: json['id'] as String?,
        name: json['name'] as String?,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        countryId: json['country_id'] as String?,
        stateId: json['state_id'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  @override
  String toString() {
    return 'City(id: $id, name: $name, latitude: $latitude, longitude: $longitude, countryId: $countryId, stateId: $stateId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
