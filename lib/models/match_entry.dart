class MatchEntry {
  final String id;
  final String season;
  final String? date;
  final String competition;

  final String home;
  final String homeSlug;
  final String away;
  final String awaySlug;

  final String score;

  MatchEntry({
    required this.id,
    required this.season,
    required this.date,
    required this.competition,
    required this.home,
    required this.homeSlug,
    required this.away,
    required this.awaySlug,
    required this.score,
  });

  factory MatchEntry.fromJson(Map<String, dynamic> json) {
    return MatchEntry(
      id: json['id'].toString(),
      season: json['season'] ?? "",
      date: json['date'],
      competition: json['competition'] ?? "",

      home: json['home_team'] ?? "",
      homeSlug: json['home_team_slug'] ?? "",
      away: json['away_team'] ?? "",
      awaySlug: json['away_team_slug'] ?? "",

      score: json['full_time_score'] ?? "",
    );
  }
}
