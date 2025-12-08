class MatchDetail {
  final String id;
  final String season;
  final DateTime? date;
  final String competition;

  final String homeTeam;
  final String homeTeamSlug;
  final String awayTeam;
  final String awayTeamSlug;

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

  MatchDetail({
    required this.id,
    required this.season,
    required this.date,
    required this.competition,
    required this.homeTeam,
    required this.homeTeamSlug,
    required this.awayTeam,
    required this.awayTeamSlug,
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

  factory MatchDetail.fromJson(Map<String, dynamic> json) {
    return MatchDetail(
      id: json["id"].toString(),
      season: json["season"] ?? "",
      date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
      competition: json["competition"] ?? "",
      homeTeam: json["home_team"] ?? "",
      homeTeamSlug: json["home_team_slug"] ?? "",
      awayTeam: json["away_team"] ?? "",
      awayTeamSlug: json["away_team_slug"] ?? "",
      fullTimeScore: json["full_time_score"] ?? "",
      halfTimeScore: json["half_time_score"] ?? "",

      shotsHome: json["shots_home"] ?? 0,
      shotsAway: json["shots_away"] ?? 0,
      shotsOnTargetHome: json["shots_on_target_home"] ?? 0,
      shotsOnTargetAway: json["shots_on_target_away"] ?? 0,
      cornersHome: json["corners_home"] ?? 0,
      cornersAway: json["corners_away"] ?? 0,
      foulsHome: json["fouls_home"] ?? 0,
      foulsAway: json["fouls_away"] ?? 0,
      yellowHome: json["yellow_cards_home"] ?? 0,
      yellowAway: json["yellow_cards_away"] ?? 0,
      redHome: json["red_cards_home"] ?? 0,
      redAway: json["red_cards_away"] ?? 0,
    );
  }
}
