import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'match_detail.dart';
import 'dart:convert';

class MatchHistory {
  final int id;
  final String home;
  final String away;
  final String score;
  final int teamId;
  final int competitionId;

  MatchHistory({
    required this.id,
    required this.home,
    required this.away,
    required this.score,
    required this.teamId,
    required this.competitionId,
  });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
      id: json['id'],
      home: json['home'],
      away: json['away'],
      score: json['score'],
      teamId: json['team_id'],
      competitionId: json['competition_id'],
    );
  }
}

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

    Map<String, String> query = {};
    if (selectedTeamId != null) query["team_id"] = selectedTeamId.toString();
    if (selectedCompetitionId != null) {
      query["competition_id"] = selectedCompetitionId.toString();
    }

    var response =
    await request.get("/api/match_history", queryParameters: query);

    List<MatchHistory> parsed =
    (response as List).map((e) => MatchHistory.fromJson(e)).toList();

    setState(() {
      history = parsed;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Match History")),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // -------------------- FILTER --------------------
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

          // -------------------- CONTENT --------------------
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final m = history[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("${m.home} vs ${m.away}"),
                    subtitle: Text("Score: ${m.score}"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MatchDetailPage(match: m),
                      ),
                    ),
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
