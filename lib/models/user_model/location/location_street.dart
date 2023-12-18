class Street {
  final int strNumber;
  final String strName;

  Street({required this.strNumber, required this.strName});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      strNumber: json['number'],
      strName: json['name'],
    );
  }
}
