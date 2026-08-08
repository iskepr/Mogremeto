import "package:hive/hive.dart";

part "evidence_document.g.dart";

@HiveType(typeId: 5)
class EvidenceDocument {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String content;

  EvidenceDocument({
    required this.title,
    required this.type,
    required this.image,
    required this.content,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "type": type,
    "image": image,
    "content": content,
  };

  factory EvidenceDocument.fromMap(Map<String, dynamic> map) =>
      EvidenceDocument(
        title: map["title"] ?? "",
        type: map["type"] ?? "",
        image: map["image"] ?? "",
        content: map["content"] ?? "",
      );

  @override
  String toString() => toMap().toString();
}
