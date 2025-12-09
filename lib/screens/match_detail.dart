import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../models/match_detail_entry.dart';
import '../services/match_service.dart';

class MatchDetailPage extends StatefulWidget {
  final String matchId;

  const MatchDetailPage({super.key, required this.matchId});

  @override
  State<MatchDetailPage> createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  MatchDetailEntry? detail;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final data = await fetchMatchDetailEntry(context, widget.matchId);
      setState(() {
        detail = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Detail"),
        backgroundColor: const Color(0xff052962),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text("Error: $error"))
          : buildDetail(),
    );
  }

  Widget buildDetail() {
    final m = detail!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Competition Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xff052962),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                m.competition,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Date
          Center(
            child: Text(
              m.date ?? "-",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 30),

          // Teams and Score
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: teamColumn(m.homeTeam, m.homeSlug),
                ),

                // Score Column
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        m.fullTimeScore,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff052962),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "HT: ${m.halfTimeScore}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: teamColumn(m.awayTeam, m.awaySlug),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Match Statistics Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff052962).withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                "MATCH STATISTICS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff052962),
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Statistics Grid
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "HOME",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff052962),
                        ),
                      ),
                      Text(
                        "STATS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff052962),
                        ),
                      ),
                      Text(
                        "AWAY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff052962),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Stats Items
                statItem("Shots", m.shotsHome, m.shotsAway),
                const Divider(height: 20),
                statItem("Shots on Target", m.shotsOnTargetHome, m.shotsOnTargetAway),
                const Divider(height: 20),
                statItem("Corners", m.cornersHome, m.cornersAway),
                const Divider(height: 20),
                statItem("Fouls", m.foulsHome, m.foulsAway),
                const Divider(height: 20),
                statItem("Yellow Cards", m.yellowHome, m.yellowAway),
                const Divider(height: 20),
                statItem("Red Cards", m.redHome, m.redAway),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Back Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff052962),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, size: 16),
                  SizedBox(width: 8),
                  Text(
                    "Back to Match History",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget teamColumn(String name, String slug) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Team Logo Placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: const Color(0xff052962).withOpacity(0.2),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.sports_soccer,
            size: 40,
            color: Color(0xff052962),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          slug,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget statItem(String label, int home, int away) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$home",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff052962),
              ),
            ),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "$away",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff052962),
              ),
            ),
          ),
        ],
      ),
    );
  }
}