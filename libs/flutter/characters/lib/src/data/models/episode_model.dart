import 'package:flutter_characters/src/domain/entities/episode_entity.dart';

class EpisodeModel extends EpisodeEntity {
  EpisodeModel({
    required super.id,
    required super.name,
    required super.airDate,
    required super.episode,
    required super.characters,
    required super.url,
    required super.created
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    id: json["id"],
    name: json["name"],
    airDate: json["air_date"],
    episode: json["episode"],
    characters: List<String>.from(json["characters"].map((x) => x)),
    url: json["url"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "air_date": airDate,
    "episode": episode,
    "characters": List<dynamic>.from(characters.map((x) => x)),
    "url": url,
    "created": created.toIso8601String(),
  };
}