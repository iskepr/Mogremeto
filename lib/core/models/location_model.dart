import "package:hive/hive.dart";

part "location_model.g.dart";

@HiveType(typeId: 2)
class Location {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  Location({required this.name, required this.image});

  Map<String, dynamic> toMap() => {"name": name, "image": image};

  factory Location.fromMap(Map<String, dynamic> map) =>
      Location(name: map["name"] ?? "", image: map["image"] ?? "");
}
