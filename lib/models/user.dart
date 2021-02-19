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
    id = map["user_detail"]["user"]["id"];
    username = map["user_detail"]["user"]["username"];
    firstName = map["user_detail"]["user"]["first_name"];
    lastName = map["user_detail"]["user"]["last_name"];
    email = map["user_detail"]["user"]["email"];
    phoneNumber = map["user_detail"]["user"]["phone_number"];
    profileImage = map["user_detail"]["user"]["profile_image"];
    address = map["user_detail"]["address"];
    city = map["user_detail"]["city"];
    postalCode = map["user_detail"]["postal_code"];
    country = map["user_detail"]["country"];
    facebookLink = map["user_detail"]["facebook_link"];
    twiterLink = map["user_detail"]["twiter_link"];
    googleLink = map["user_detail"]["google_link"];
    pintrestLink = map["user_detail"]["pintrest_link"];
    bio = map["user_detail"]["bio"];
    timeStamp = map["user_detail"]["time_stamp"];
  }
}
