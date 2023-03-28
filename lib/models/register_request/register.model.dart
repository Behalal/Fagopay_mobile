class Register {
  // Creating a Field/Property
  late String accountType;
  late String verification;
  late String id;
  late String firstname;
  late String lastname;
  late String email;
  late String referral;

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

  // Creating the setter method
  // to set the input in Field/Property
  set setId(String name) {
    id = name;
  }

  String get getFirstname {
    return firstname;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setFirstname(String name) {
    firstname = name;
  }

  String get getlastname {
    return lastname;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setLastname(String name) {
    lastname = name;
  }

  String get getEmail {
    return email;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setEmail(String name) {
    email = name;
  }

  String get getReferral {
    return referral;
  }

  // Creating the setter method
  // to set the input in Field/Property
  set setReferral(String name) {
    referral = name;
  }
}

Register registrationData = Register();
