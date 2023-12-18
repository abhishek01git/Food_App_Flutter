import 'package:food_api/models/user_model/location/location_cordinates.dart';
import 'package:food_api/models/user_model/location/location_street.dart';
import 'package:food_api/models/user_model/location/location_timezone.dart';

class UserLocation {
  final String city;
  final String state;
  final String country;
  final int postCode;
  final Street street;
  final Coordinates coordinates;
  final TimeZone timeZone;

  UserLocation({
    required this.city,
    required this.state,
    required this.country,
    required this.postCode,
    required this.street,
    required this.coordinates,
    required this.timeZone,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    final street = Street.fromJson(json['street']);
    final coordinates = Coordinates.fromJson(json['coordinates']);
    final timeZone = TimeZone.fromJson(json['timezone']);
    return UserLocation(
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postCode: json['postcode'],
      street: street,
      coordinates: coordinates,
      timeZone: timeZone,
    );
  }
}
