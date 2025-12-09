class ForumComment {
  final String id;
  final String forumId;
  final String author;
  final String authorRole;
  final String text;
  final DateTime createdAt;
  final String? parentId;
  final String? replyToUsername;
  final List<ForumComment> replies;

  ForumComment({
    required this.id,
    required this.forumId,
    required this.author,
    required this.authorRole,
    required this.text,
    required this.createdAt,
    required this.parentId,
    required this.replyToUsername,
    required this.replies,
  });

  factory ForumComment.fromJson(Map<String, dynamic> json) {
    return ForumComment(
      id: json["id"],
      forumId: json["forum_id"],
      author: json["author"],
      authorRole: json["author_role"] ?? "user",
      text: json["text"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
      parentId: json["parent_id"],
      replyToUsername: json["reply_to_username"],
      replies: (json["replies"] as List? ?? [])
          .map((e) => ForumComment.fromJson(e))
          .toList(),
    );
  }
}
