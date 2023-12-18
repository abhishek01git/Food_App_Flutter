

class UserPicture {
  final String largeImg;
  final String mediumImg;
  final String thumbNail;

  UserPicture(
      {required this.largeImg,
      required this.mediumImg,
      required this.thumbNail});

  factory UserPicture.fromJson(Map<String, dynamic> json) {
    return UserPicture(
      largeImg: json['large'],
      mediumImg: json['medium'],
      thumbNail: json['thumbnail'],
    );
  }
}
