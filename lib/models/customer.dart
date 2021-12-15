import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String fullName = "";
  String displayName = "";

  String email = "";
  int identityId;
  String uId;
  String address = "";
  String phoneNumber;
  Timestamp lastOnlineTimestamp;
  String profilePictureURL;

  Customer(
      {this.email = '',
      this.fullName = '',

      this.identityId = 0,

      this.displayName='',
      this.address='',
      this.phoneNumber='',
      lastOnlineTimestamp,
      this.uId = "",
      this.profilePictureURL = ''})
      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now();

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    return new Customer(
        email: parsedJson['email'] ?? '',
        fullName: parsedJson['fullName'] ?? '',
        displayName: parsedJson['displayName'] ?? '',
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        identityId: parsedJson['identityId'] ?? '',
        address: parsedJson['address'] ?? '',
        uId: parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'fullName': this.fullName,
      'displayName': this.displayName,
      'phoneNumber': this.phoneNumber,
      'identityId': this.identityId,
      'address': this.address,
      'uId': this.uId,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL
    };
  }
}
