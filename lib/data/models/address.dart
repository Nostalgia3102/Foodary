import 'package:location/location.dart';

class Address{
  String city;
  String street;
  String postalCode;
  Location location;
  String state;
  String addressId;

  Address({
    required this.city,
    required this.street,
    required this.postalCode,
    required this.location,
    required this.state,
    required this.addressId,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    city: json["city"],
    street: json["street"],
    postalCode: json["postalCode"],
    location: json["location"],
    state: json["state"],
    addressId: json["addressId"],
  );

  Map<String, dynamic> toMap() => {
    "city": city,
    "street": street,
    "postalCode": postalCode,
    "location": location,
    "state": state,
    "addressId": addressId,
  };
}