import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'match_detail.dart';
import '../widgets/match_card.dart';

// ================= MODEL =================
class MatchHistory {
  final String id;
  final String home;
  final String away;
  final String score;
  final String season;
  final String competition;
  final String date;
  final String homeSlug;
  final String awaySlug;

  MatchHistory({
    required this.id,
    required this.home,
    required this.away,
    required this.score,
    required this.season,
    required this.competition,
    required this.date,
    required this.homeSlug,
    required this.awaySlug,
  });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
      id: json['id'].toString(),
      home: json['home_team'] ?? "",
      away: json['away_team'] ?? "",
      score: json['full_time_score'] ?? "-",
      season: json['season'] ?? "",
      competition: json['competition'] ?? "",
      date: json['date'] ?? "",
      homeSlug: json['home_team_slug'] ?? "",
      awaySlug: json['away_team_slug'] ?? "",
    );
  }
}

// Model untuk Team dropdown
class TeamItem {
  final String slug;
  final String name;

  TeamItem({required this.slug, required this.name});
}

// ================= PAGE =================
class MatchHistoryPage extends StatefulWidget {
  const MatchHistoryPage({super.key});

  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  String? selectedTeamSlug;
  String? selectedCompetition;

  List<MatchHistory> history = [];
  bool loading = true;
  String? error;

  // Data untuk dropdown - menggunakan model
  final List<TeamItem> teams = [
    TeamItem(slug: 'arsenal', name: 'Arsenal'),
    TeamItem(slug: 'chelsea', name: 'Chelsea'),
    TeamItem(slug: 'liverpool', name: 'Liverpool'),
    TeamItem(slug: 'manchester-united', name: 'Manchester United'),
  ];

  final List<String> competitions = [
    'Premier League',
    'FA Cup',
    'Champions League',
    'Europa League',
  ];

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final request = context.read<CookieRequest>();

      String baseUrl =
          "http://127.0.0.1:8000/api/matches/";

      final params = <String, String>{};

      if (selectedTeamSlug != null) {
        params["team_id"] = selectedTeamSlug!;
      }

      if (selectedCompetition != null) {
        params["competition_id"] = selectedCompetition!;
      }

      final uri = Uri.parse(baseUrl).replace(queryParameters: params);

      print("FETCHING: $uri");

      final response = await request.get(uri.toString());

      // 🔥 VALIDASI RESPONSE
      if (response is! List) {
        throw Exception(
          "Expected List JSON, got ${response.runtimeType}",
        );
      }

      final parsed = response
          .map<MatchHistory>((e) => MatchHistory.fromJson(e))
          .toList();

      setState(() {
        history = parsed;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
      debugPrint("FETCH HISTORY ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Match History",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff052962),
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                const Row(
                  children: [
                    Icon(Icons.filter_list, color: Color(0xff052962)),
                    SizedBox(width: 8),
                    Text(
                      "Filter Matches",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff052962),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          labelText: "Team",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                        ),
                        value: selectedTeamSlug,
                        isExpanded: true,
                        items: [
                          const DropdownMenuItem<String?>(
                            value: null,
                            child: Text("All Teams"),
                          ),
                          ...teams.map(
                                (team) => DropdownMenuItem<String?>(
                              value: team.slug,
                              child: Text(team.name),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedTeamSlug = value);
                          fetchHistory();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          labelText: "Competition",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                        ),
                        value: selectedCompetition,
                        isExpanded: true,
                        items: [
                          const DropdownMenuItem<String?>(
                            value: null,
                            child: Text("All Competitions"),
                          ),
                          ...competitions.map(
                                (comp) => DropdownMenuItem<String?>(
                              value: comp,
                              child: Text(comp),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedCompetition = value);
                          fetchHistory();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Count
          if (!loading && history.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${history.length} matches found",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: fetchHistory,
                    icon: const Icon(Icons.refresh),
                    color: const Color(0xff052962),
                  ),
                ],
              ),
            ),

          // Content Section
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Error: $error",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: fetchHistory,
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            )
                : history.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sports_soccer,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No matches found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final m = history[i];
                return MatchCard(match: m);
              },
            ),
          ),
        ],
      ),
    );
  }
}
