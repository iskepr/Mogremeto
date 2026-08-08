import "package:hive/hive.dart";

part "victim_model.g.dart";

@HiveType(typeId: 1)
class Victim {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String role;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String details;

  Victim({
    required this.name,
    required this.role,
    required this.image,
    required this.details,
  });

  Map<String, dynamic> toMap() => {
    "name": name,
    "role": role,
    "image": image,
    "details": details,
  };

  factory Victim.fromMap(Map<String, dynamic> map) => Victim(
    name: map["name"] ?? "",
    role: map["role"] ?? "",
    image: map["image"] ?? "",
    details: map["details"] ?? "",
  );

  @override
  String toString() => toMap().toString();
}
