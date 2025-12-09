import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import '../models/match_detail_entry.dart';
import 'package:provider/provider.dart';

Future<MatchDetailEntry> fetchMatchDetailEntry(
    BuildContext context,
    String id,
    ) async {
  final request = context.read<CookieRequest>();

  final url =
      "https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/matches/$id/";

  print("FETCHING URL: $url");

  try {
    final response = await request.get(url);
    print("API RESPONSE: $response");

    if (response is Map<String, dynamic>) {
      return MatchDetailEntry.fromJson(response);
    } else {
      throw Exception("Invalid response format");
    }
  } catch (e) {
    print("ERROR FETCH DETAIL: $e");
    throw Exception("Failed to load match details: $e");
  }
}