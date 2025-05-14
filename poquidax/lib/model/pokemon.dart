class Pokemon {
  final int number;
  final String name;
  final String sprite;
  final String type;
  final int hp;

  const Pokemon({
    required this.number,
    required this.name,
    required this.sprite,
    required this.type,
    required this.hp,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      number: json['number'] as int,
      name: json['name'] as String,
      sprite: json['sprite'] as String,
      type: json['type'] as String,
      hp: json['hp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'sprite': sprite,
      'type': type,
      'hp': hp,
    };
  }
}
