import 'package:flutter/material.dart';
import '../models/forum_entry.dart';

class ForumCard extends StatelessWidget {
  final Forum forum;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onBookmark;

  const ForumCard({
    super.key,
    required this.forum,
    this.onTap,
    this.onLike,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (forum.context != null) _buildPreview(forum.context!),
              const SizedBox(height: 8),

              Text(
                forum.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                forum.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '@${forum.author}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Spacer(),

                  IconButton(
                    icon: Icon(
                      forum.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: forum.isLiked ? Colors.red : null,
                      size: 20,
                    ),
                    onPressed: onLike,
                  ),
                  Text('${forum.likeCount}'),

                  const SizedBox(width: 8),

                  IconButton(
                    icon: Icon(
                      forum.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 20,
                    ),
                    onPressed: onBookmark,
                  ),
                  Text('${forum.bookmarkCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(Map<String, dynamic> ctx) {
    if (ctx["type"] == "news") {
      return Row(
        children: [
          if (ctx["thumbnail_url"] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                ctx["thumbnail_url"],
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              ctx["title"] ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    if (ctx["type"] == "match") {
      return Row(
        children: [
          Expanded(
            child: Text(
              '${ctx['home_team_name']} vs ${ctx['away_team_name']}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Text(
            '${ctx['home_team_score']} : ${ctx['away_team_score']}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
