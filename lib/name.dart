class Name {
  final String title;
  final String first;
  final String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> name) {
    return Name(
      title: name['title'],
      first: name['first'],
      last: name['last'],
    );
  }
}
