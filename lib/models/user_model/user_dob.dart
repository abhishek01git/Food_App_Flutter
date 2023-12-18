class UserDOB {
  final String date;
  final int age;

  UserDOB({required this.date, required this.age});

  factory UserDOB.fromJson(Map<String, dynamic> json) {
    return UserDOB(
      date: json['date'],
      age: json['age'],
    );
  }
}
