class CustomPokemon {
  final String user;
  final int id;
  final int number;
  final String name;
  final int level;
  final int hp;

  const CustomPokemon(
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
}
