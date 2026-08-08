import "package:hive/hive.dart";

part "weapon_model.g.dart";

@HiveType(typeId: 3)
class Weapon {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  Weapon({required this.name, required this.image});

  Map<String, dynamic> toMap() => {"name": name, "image": image};

  factory Weapon.fromMap(Map<String, dynamic> map) =>
      Weapon(name: map["name"] ?? "", image: map["image"] ?? "");

  @override
  String toString() => toMap().toString();
}
