// To parse this JSON data, do
//
//     final matchEntry = matchEntryFromJson(jsonString);

import 'dart:convert';

List<MatchEntry> matchEntryFromJson(String str) => List<MatchEntry>.from(json.decode(str).map((x) => MatchEntry.fromJson(x)));

String matchEntryToJson(List<MatchEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchEntry {
  final String id;
  final String season;
  final DateTime? date;
  final String competition;
  final String homeTeam;
  final String homeTeamSlug;
  final String awayTeam;
  final String awayTeamSlug;
  final String fullTimeScore;

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

  factory MatchEntry.fromJson(Map<String, dynamic> json) {
    return MatchEntry(
      id: json["id"],
      season: json["season"] ?? "",
      date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
      competition: json["competition"] ?? "",
      homeTeam: json["home_team"] ?? "",
      homeTeamSlug: json["home_team_slug"] ?? "",
      awayTeam: json["away_team"] ?? "",
      awayTeamSlug: json["away_team_slug"] ?? "",
      fullTimeScore: json["full_time_score"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "season": season,
    "date": date?.toIso8601String(),
    "competition": competition,
    "home_team": homeTeam,
    "home_team_slug": homeTeamSlug,
    "away_team": awayTeam,
    "away_team_slug": awayTeamSlug,
    "full_time_score": fullTimeScore,
  };
}