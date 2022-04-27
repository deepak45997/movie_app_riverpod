// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcoome welcomeFromJson(String str) => Welcoome.fromJson(json.decode(str));

String welcomeToJson(Welcoome data) => json.encode(data.toJson());

class Welcoome {
  Welcoome({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory Welcoome.fromJson(Map<String, dynamic> json) => Welcoome(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    required this.id,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.voteCount,
    required this.backdropPath,
    required this.originalName,
    required this.genreIds,
    required this.name,
    required this.originalLanguage,
    required this.popularity,
    required this.mediaType,
    required this.originalTitle,
    required this.video,
    required this.releaseDate,
    required this.adult,
    required this.title,
  });

  int? id;
  String? posterPath;
  double? voteAverage;
  String? overview;
  DateTime? firstAirDate;

  int? voteCount;
  String? backdropPath;
  String? originalName;
  List<int> genreIds;
  String? name;
  OriginalLanguage? originalLanguage;
  double? popularity;
  MediaType? mediaType;
  String? originalTitle;
  bool? video;
  DateTime? releaseDate;
  bool? adult;
  String? title;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        voteCount: json["vote_count"],
        backdropPath: json["backdrop_path"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map[json["media_type"]],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        video: json["video"] == null ? null : json["video"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        adult: json["adult"] == null ? null : json["adult"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "vote_count": voteCount,
        "backdrop_path": backdropPath,
        "original_name": originalName == null ? null : originalName,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "name": name == null ? null : name,
        "original_language": originalLanguageValues.reverse![originalLanguage],
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse![mediaType],
        "original_title": originalTitle == null ? null : originalTitle,
        "video": video == null ? null : video,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "adult": adult == null ? null : adult,
        "title": title == null ? null : title,
      };
}

enum MediaType { TV, MOVIE }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

enum OriginalLanguage { EN, ES, KO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ko": OriginalLanguage.KO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
