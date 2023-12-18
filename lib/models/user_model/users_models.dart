import 'package:food_api/models/user_model/location/user_location.dart';
import 'package:food_api/models/user_model/user_dob.dart';
import 'package:food_api/models/user_model/user_name.dart';
import 'package:food_api/models/user_model/user_picture.dart';

class UserModel {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserLocation location;
  final UserDOB dob;
  final UserPicture picture;

  UserModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = UserName.fromJson(json['name']);
    final location = UserLocation.fromJson(json['location']);
    final dob = UserDOB.fromJson(json['dob']);
    final picture = UserPicture.fromJson(json['picture']);

    return UserModel(
      gender: json['gender'],
      name: name,
      location: location,
      email: json['email'],
      dob: dob,
      phone: json['phone'],
      cell: json['cell'],
      picture: picture,
      nat: json['nat'],
    );
  }
}
