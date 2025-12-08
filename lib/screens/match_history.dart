import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'match_detail.dart';

// ================= MODEL =================

class MatchHistory {
  final String id;
  final String home;
  final String away;
  final String score;
  final String season;
  final String competition;
  final String date;

  MatchHistory({
    required this.id,
    required this.home,
    required this.away,
    required this.score,
    required this.season,
    required this.competition,
    required this.date,
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
    );
  }
}

// ================= PAGE =================

class MatchHistoryPage extends StatefulWidget {
  const MatchHistoryPage({super.key});

  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  int? selectedTeamId;
  int? selectedCompetitionId;

  List<MatchHistory> history = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final request = context.read<CookieRequest>();

    String baseUrl =
        "https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/matches";

    List<String> params = [];
    if (selectedTeamId != null) params.add("team_id=$selectedTeamId");
    if (selectedCompetitionId != null) {
      params.add("competition_id=$selectedCompetitionId");
    }

    String finalUrl = params.isEmpty
        ? baseUrl
        : "$baseUrl?${params.join("&")}";

    print("FETCHING FROM: $finalUrl");

    try {
      var response = await request.get(finalUrl);

      List raw;

      if (response is List) {
        raw = response;
      } else if (response is Map && response["data"] is List) {
        raw = response["data"];
      } else {
        throw Exception("Unexpected API format: $response");
      }

      List<MatchHistory> parsed =
      raw.map((e) => MatchHistory.fromJson(e)).toList();

      setState(() {
        history = parsed;
        loading = false;
      });
    } catch (e) {
      print("ERROR FETCHING HISTORY: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Match History")),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // --------------- FILTER ---------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    hint: const Text("Team"),
                    isExpanded: true,
                    value: selectedTeamId,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Team A")),
                      DropdownMenuItem(value: 2, child: Text("Team B")),
                    ],
                    onChanged: (v) {
                      setState(() => selectedTeamId = v);
                      fetchHistory();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<int>(
                    hint: const Text("Competition"),
                    isExpanded: true,
                    value: selectedCompetitionId,
                    items: const [
                      DropdownMenuItem(value: 10, child: Text("League 1")),
                      DropdownMenuItem(value: 20, child: Text("League 2")),
                    ],
                    onChanged: (v) {
                      setState(() => selectedCompetitionId = v);
                      fetchHistory();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // --------------- CONTENT ---------------
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final m = history[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("${m.home} vs ${m.away}"),
                    subtitle: Text(
                      "${m.competition} • ${m.season}\nDate: ${m.date}",
                    ),
                    trailing: Text(
                      m.score,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MatchDetailPage(match: m),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
