class CustomPokemon {
  String user;
  int id;
  int number;
  String name;
  int level;
  int hp;

  CustomPokemon(
      {required this.user,
      required this.id,
      required this.number,
      required this.name,
      required this.level,
      required this.hp});

  factory CustomPokemon.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'user': String user,
        'id': int id,
        'number': int number,
        'name': String name,
        'level': int level,
        'hp': int hp
      } =>
        CustomPokemon(
          user: user,
          id: id,
          number: number,
          name: name,
          level: level,
          hp: hp,
        ),
      _ => throw const FormatException('Failed to load pokemon.'),
    };
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'id': id,
        'number': number,
        'name': name,
        'level': level,
        'hp': hp,
      };
}
