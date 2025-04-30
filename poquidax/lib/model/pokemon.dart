class Pokemon {
  final int number;
  final String name;

  const Pokemon(
      {required this.number,
      required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      number: int.parse(json['number'].toString()),
    );
  }
}
