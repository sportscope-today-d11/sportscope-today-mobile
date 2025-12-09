class MatchDetailEntry {
  final String competition;
  final String? date;

  final String homeTeam;
  final String awayTeam;

  final String homeSlug;
  final String awaySlug;

  final String fullTimeScore;
  final String halfTimeScore;

  final int shotsHome;
  final int shotsAway;

  final int shotsOnTargetHome;
  final int shotsOnTargetAway;

  final int cornersHome;
  final int cornersAway;

  final int foulsHome;
  final int foulsAway;

  final int yellowHome;
  final int yellowAway;

  final int redHome;
  final int redAway;

  MatchDetailEntry({
    required this.competition,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeSlug,
    required this.awaySlug,
    required this.fullTimeScore,
    required this.halfTimeScore,
    required this.shotsHome,
    required this.shotsAway,
    required this.shotsOnTargetHome,
    required this.shotsOnTargetAway,
    required this.cornersHome,
    required this.cornersAway,
    required this.foulsHome,
    required this.foulsAway,
    required this.yellowHome,
    required this.yellowAway,
    required this.redHome,
    required this.redAway,
  });

  factory MatchDetailEntry.fromJson(Map<String, dynamic> json) {
    // Parse score strings
    String fullTimeScore = json["full_time_score"] ?? "0 - 0";
    String halfTimeScore = json["half_time_score"] ?? "0 - 0";

    return MatchDetailEntry(
      competition: json["competition"] ?? "Premier League",
      date: json["date"] ?? "",
      homeTeam: json["home_team"] ?? "",
      awayTeam: json["away_team"] ?? "",
      homeSlug: json["home_team_slug"] ?? "",
      awaySlug: json["away_team_slug"] ?? "",
      fullTimeScore: fullTimeScore,
      halfTimeScore: halfTimeScore,
      shotsHome: json["shots_home"] is int ? json["shots_home"] : int.tryParse(json["shots_home"]?.toString() ?? "0") ?? 0,
      shotsAway: json["shots_away"] is int ? json["shots_away"] : int.tryParse(json["shots_away"]?.toString() ?? "0") ?? 0,
      shotsOnTargetHome: json["shots_on_target_home"] is int ? json["shots_on_target_home"] : int.tryParse(json["shots_on_target_home"]?.toString() ?? "0") ?? 0,
      shotsOnTargetAway: json["shots_on_target_away"] is int ? json["shots_on_target_away"] : int.tryParse(json["shots_on_target_away"]?.toString() ?? "0") ?? 0,
      cornersHome: json["corners_home"] is int ? json["corners_home"] : int.tryParse(json["corners_home"]?.toString() ?? "0") ?? 0,
      cornersAway: json["corners_away"] is int ? json["corners_away"] : int.tryParse(json["corners_away"]?.toString() ?? "0") ?? 0,
      foulsHome: json["fouls_home"] is int ? json["fouls_home"] : int.tryParse(json["fouls_home"]?.toString() ?? "0") ?? 0,
      foulsAway: json["fouls_away"] is int ? json["fouls_away"] : int.tryParse(json["fouls_away"]?.toString() ?? "0") ?? 0,
      yellowHome: json["yellow_cards_home"] is int ? json["yellow_cards_home"] : int.tryParse(json["yellow_cards_home"]?.toString() ?? "0") ?? 0,
      yellowAway: json["yellow_cards_away"] is int ? json["yellow_cards_away"] : int.tryParse(json["yellow_cards_away"]?.toString() ?? "0") ?? 0,
      redHome: json["red_cards_home"] is int ? json["red_cards_home"] : int.tryParse(json["red_cards_home"]?.toString() ?? "0") ?? 0,
      redAway: json["red_cards_away"] is int ? json["red_cards_away"] : int.tryParse(json["red_cards_away"]?.toString() ?? "0") ?? 0,
    );
  }

}
