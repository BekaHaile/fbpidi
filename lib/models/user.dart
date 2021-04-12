class User {
  String id;
  String username;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String profileImage;
  String address;
  String city;
  String postalCode;
  String country;
  String facebookLink;
  String twiterLink;
  String googleLink;
  String pintrestLink;
  String bio;
  String timeStamp;
  String password;

  User(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profileImage,
      this.address,
      this.city,
      this.postalCode,
      this.country,
      this.facebookLink,
      this.twiterLink,
      this.googleLink,
      this.pintrestLink,
      this.bio,
      this.timeStamp,
      this.password});

  User.fromMap(Map<dynamic, dynamic> map) {
    id = map["user"]["id"].toString();
    username = map["user"]["username"].toString();
    firstName = map["user"]["first_name"].toString();
    lastName = map["user"]["last_name"].toString();
    email = map["user"]["email"].toString();
    phoneNumber = map["user"]["phone_number"].toString();
    profileImage = map["user"]["profile_image"].toString();
    address = map["address"].toString();
    city = map["city"].toString();
    postalCode = map["postal_code"].toString();
    country = map["country"].toString();
    facebookLink = map["facebook_link"].toString();
    twiterLink = map["twiter_link"].toString();
    googleLink = map["google_link"].toString();
    pintrestLink = map["pintrest_link"].toString();
    bio = map["bio"].toString();
    timeStamp = map["time_stamp"].toString();
  }
}
