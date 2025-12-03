// To parse this JSON data, do
//
//     final matchEntry = matchEntryFromJson(jsonString);

import 'dart:convert';

List<MatchEntry> matchEntryFromJson(String str) => List<MatchEntry>.from(json.decode(str).map((x) => MatchEntry.fromJson(x)));

String matchEntryToJson(List<MatchEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchEntry {
  String id;
  Season season;
  DateTime date;
  Competition competition;
  String homeTeam;
  String homeTeamSlug;
  String awayTeam;
  String awayTeamSlug;
  String fullTimeScore;

  MatchEntry({
    required this.id,
    required this.season,
    required this.date,
    required this.competition,
    required this.homeTeam,
    required this.homeTeamSlug,
    required this.awayTeam,
    required this.awayTeamSlug,
    required this.fullTimeScore,
  });

  factory MatchEntry.fromJson(Map<String, dynamic> json) => MatchEntry(
    id: json["id"],
    season: seasonValues.map[json["season"]]!,
    date: DateTime.parse(json["date"]),
    competition: competitionValues.map[json["competition"]]!,
    homeTeam: json["home_team"],
    homeTeamSlug: json["home_team_slug"],
    awayTeam: json["away_team"],
    awayTeamSlug: json["away_team_slug"],
    fullTimeScore: json["full_time_score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "season": seasonValues.reverse[season],
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "competition": competitionValues.reverse[competition],
    "home_team": homeTeam,
    "home_team_slug": homeTeamSlug,
    "away_team": awayTeam,
    "away_team_slug": awayTeamSlug,
    "full_time_score": fullTimeScore,
  };
}

enum Competition {
  UNKNOWN
}

final competitionValues = EnumValues({
  "Unknown": Competition.UNKNOWN
});

enum Season {
  THE_202425
}

final seasonValues = EnumValues({
  "2024/25": Season.THE_202425
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
