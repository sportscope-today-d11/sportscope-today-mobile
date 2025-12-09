import 'package:flutter/material.dart';
import '../models/comment_entry.dart';

class CommentCard extends StatelessWidget {
  final ForumComment comment;
  final void Function(ForumComment)? onReply;

  const CommentCard({
    super.key,
    required this.comment,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSingle(comment),
        if (comment.replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: comment.replies
                  .map((c) => _buildSingle(c, isChild: true))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildSingle(ForumComment c, {bool isChild = false}) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: isChild ? 16 : 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('@${c.author}', style: const TextStyle(fontWeight: FontWeight.bold)),
                if (c.replyToUsername != null)
                  Text(' → @${c.replyToUsername}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Text(c.text),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => onReply?.call(c),
                child: const Text('Reply', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
