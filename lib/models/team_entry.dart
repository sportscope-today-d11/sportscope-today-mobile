// To parse this JSON data, do
//
//     final teamEntry = teamEntryFromJson(jsonString);

import 'dart:convert';

TeamEntry teamEntryFromJson(String str) => TeamEntry.fromJson(json.decode(str));

String teamEntryToJson(TeamEntry data) => json.encode(data.toJson());

class TeamEntry {
    String slug;
    String name;
    int players;
    double age;
    double possession;
    int goals;
    int assists;
    int penaltyKicks;
    int penaltyKickAttempts;
    int yellows;
    int reds;
    String imageUrl;

    TeamEntry({
        required this.slug,
        required this.name,
        required this.players,
        required this.age,
        required this.possession,
        required this.goals,
        required this.assists,
        required this.penaltyKicks,
        required this.penaltyKickAttempts,
        required this.yellows,
        required this.reds,
        required this.imageUrl,
    });

    factory TeamEntry.fromJson(Map<String, dynamic> json) => TeamEntry(
        slug: json["slug"],
        name: json["name"],
        players: json["players"],
        age: json["age"]?.toDouble(),
        possession: json["possession"]?.toDouble(),
        goals: json["goals"],
        assists: json["assists"],
        penaltyKicks: json["penalty_kicks"],
        penaltyKickAttempts: json["penalty_kick_attempts"],
        yellows: json["yellows"],
        reds: json["reds"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "players": players,
        "age": age,
        "possession": possession,
        "goals": goals,
        "assists": assists,
        "penalty_kicks": penaltyKicks,
        "penalty_kick_attempts": penaltyKickAttempts,
        "yellows": yellows,
        "reds": reds,
        "image_url": imageUrl,
    };
}
