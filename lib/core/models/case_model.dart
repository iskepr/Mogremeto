import "dart:convert";

import "package:hive/hive.dart";

import "evidence_document.dart";
import "location_model.dart";
import "suspect_model.dart";
import "victim_model.dart";
import "weapon_model.dart";

part "case_model.g.dart";

@HiveType(typeId: 6)
enum GameMode {
  @HiveField(0)
  roleplay("جماعي"),
  @HiveField(1)
  detective("تحقيق");

  static GameMode? fromLable(String? lable) {
    if (lable == null) return null;
    try {
      return GameMode.values.byName(lable);
    } catch (_) {
      return null;
    }
  }

  const GameMode(String name);
}

@HiveType(typeId: 0)
class CaseModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final GameMode gameMode;

  @HiveField(4)
  final String difficulty;

  @HiveField(5)
  final Victim? victim;

  @HiveField(6)
  final Location? location;

  @HiveField(7)
  final String timeOfCrime;

  @HiveField(8)
  final Weapon? weapon;

  @HiveField(9)
  final List<Suspect> suspects;

  @HiveField(10)
  final List<EvidenceDocument> evidenceDocuments;

  @HiveField(11)
  final String story;

  @HiveField(12)
  final String culpritExplanation;

  @HiveField(13)
  final bool real;

  @HiveField(14)
  final String source;

  CaseModel({
    required this.id,
    required this.title,
    required this.type,
    this.gameMode = GameMode.roleplay,
    required this.difficulty,
    this.victim,
    this.location,
    required this.timeOfCrime,
    this.weapon,
    required this.suspects,
    required this.evidenceDocuments,
    required this.story,
    required this.culpritExplanation,
    required this.real,
    required this.source,
  });

  CaseModel copyWith({
    int? id,
    String? title,
    String? type,
    GameMode? gameMode,
    String? difficulty,
    Victim? victim,
    Location? location,
    String? timeOfCrime,
    Weapon? weapon,
    List<Suspect>? suspects,
    List<EvidenceDocument>? evidenceDocuments,
    String? story,
    String? culpritExplanation,
    bool? real,
    String? source,
  }) {
    return CaseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      gameMode: gameMode ?? this.gameMode,
      difficulty: difficulty ?? this.difficulty,
      victim: victim ?? this.victim,
      location: location ?? this.location,
      timeOfCrime: timeOfCrime ?? this.timeOfCrime,
      weapon: weapon ?? this.weapon,
      suspects: suspects ?? this.suspects,
      evidenceDocuments: evidenceDocuments ?? this.evidenceDocuments,
      story: story ?? this.story,
      culpritExplanation: culpritExplanation ?? this.culpritExplanation,
      real: real ?? this.real,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "type": type,
      "game_mode": gameMode.name,
      "difficulty": difficulty,
      "victim": victim?.toMap(),
      "location": location?.toMap(),
      "time_of_crime": timeOfCrime,
      "weapon": weapon?.toMap(),
      "suspects": suspects.map((x) => x.toMap()).toList(),
      "evidence_documents": evidenceDocuments.map((x) => x.toMap()).toList(),
      "story": story,
      "culprit_explanation": culpritExplanation,
      "real": real,
      "source": source,
    };
  }

  factory CaseModel.fromMap(Map<String, dynamic> map) {
    List<EvidenceDocument> parsedEvidence = [];
    if (map["evidence_documents"] != null) {
      parsedEvidence = List<EvidenceDocument>.from(
        (map["evidence_documents"] as List<dynamic>).map(
          (x) => EvidenceDocument.fromMap(x as Map<String, dynamic>),
        ),
      );
    } else if (map["evidence"] != null) {
      parsedEvidence = (map["evidence"] as List<dynamic>)
          .asMap()
          .entries
          .map(
            (entry) => EvidenceDocument(
              title: "دليل ${entry.key + 1}",
              type: "text",
              image: "",
              content: entry.value.toString(),
            ),
          )
          .toList();
    }

    return CaseModel(
      id: map["id"],
      title: map["title"] ?? "",
      type: map["type"] ?? "",
      gameMode: GameMode.fromLable(map["game_mode"]) ?? GameMode.roleplay,
      difficulty: map["difficulty"] ?? "متوسط",
      victim: map["victim"] != null ? Victim.fromMap(map["victim"]) : null,
      location: map["location"] != null
          ? Location.fromMap(map["location"])
          : null,
      timeOfCrime: map["time_of_crime"] ?? "",
      weapon: map["weapon"] != null ? Weapon.fromMap(map["weapon"]) : null,
      suspects: List<Suspect>.from(
        (map["suspects"] as List).map((x) => Suspect.fromMap(x)),
      ),
      evidenceDocuments: parsedEvidence,
      story: map["story"] ?? "",
      culpritExplanation: map["culprit_explanation"] ?? map["story"] ?? "",
      real: map["real"] ?? false,
      source: map["source"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CaseModel.fromJson(String source) =>
      CaseModel.fromMap(json.decode(source));

  @override
  String toString() => toMap().toString();
}
