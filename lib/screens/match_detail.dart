import 'package:flutter/material.dart';
import 'match_history.dart';

class MatchDetailPage extends StatelessWidget {
  final MatchHistory match;

  const MatchDetailPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Match Detail")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${match.home} vs ${match.away}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Score: ${match.score}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            const Text(
              "Match Stats",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("- Possession: 55% - 45%"),
            const Text("- Shots: 12 - 9"),
            const Text("- Fouls: 8 - 10"),
          ],
        ),
      ),
    );
  }
}
