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
      "http://127.0.0.1:8000/api/matches/$id/";

  try {
    final response = await request.get(url);

    if (response is! Map<String, dynamic>) {
      throw Exception("Invalid JSON format");
    }

    return MatchDetailEntry.fromJson(response);
  } catch (e) {
    debugPrint("DETAIL ERROR: $e");
    rethrow;
  }
}

