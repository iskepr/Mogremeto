import "package:hive/hive.dart";

part "suspect_model.g.dart";

@HiveType(typeId: 4)
class Suspect {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String role;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final bool isCulprit;

  Suspect({
    required this.name,
    required this.role,
    required this.image,
    required this.description,
    required this.isCulprit,
  });

  Map<String, dynamic> toMap() => {
    "name": name,
    "role": role,
    "image": image,
    "description": description,
    "is_culprit": isCulprit,
  };

  factory Suspect.fromMap(Map<String, dynamic> map) => Suspect(
    name: map["name"] ?? "",
    role: map["role"] ?? "",
    image: map["image"] ?? "",
    description: map["description"] ?? "",
    isCulprit: map["is_culprit"] ?? false,
  );

  @override
  String toString() => toMap().toString();
}
