class KycDetails {
  // Creating a Field/Property
  late String accountType;
  late String verification;
  late String id;
  late String? companyName;
  late String email;
  late String phoneno;
  late String? companyAddress;
  late String? cacRegNumber;
  late String? companyType;
  late String _dob;
  late String _bvn;

  String get dob => _dob;

  set dob(String dob) {
    _dob = dob;
  }

  String get bvn => _bvn;

  set setbvn(String bvn) {
    _bvn = bvn;
  }

  late String _address;

  String get address => _address;

  set address(String address) {
    _address = address;
  }

  late String _state;

  String get state => _state;

  set state(String state) {
    _state = state;
  }

  late String _city;

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  late String _country;

  String get country => _country;

  set country(String country) {
    _country = country;
  }

  // Creating the getter method
  // to get input from Field/Property
  String get getAccountType {
    return accountType;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setAccountType(String name) {
    accountType = name;
  }

  String get getVerification {
    return verification;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setVerification(String name) {
    verification = name;
  }

  String get getId {
    return id;
  }

  set setId(String idValue) {
    id = idValue;
  }

  // Creating the setter method
  // to set the input in Field/Property

  String get getEmail {
    return email;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setEmail(String name) {
    email = name;
  }

  String get getComapnyName {
    return companyName!;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setComapnyName(String name) {
    companyName = name;
  }

  String get getPhone {
    return phoneno;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setPhone(String name) {
    phoneno = name;
  }

  String get getCompanyAddress {
    return companyAddress!;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setCompanyAddress(String name) {
    companyAddress = name;
  }

  String get getCacRegNumber {
    return cacRegNumber!;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setCacRegNumber(String name) {
    cacRegNumber = name;
  }

  String get getCompanyType {
    return companyType!;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setCompanyType(String name) {
    companyType = name;
  }
}

KycDetails KycDetailsValue = KycDetails();
