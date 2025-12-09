class Forum {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorRole;
  final DateTime createdAt;
  final Map<String, dynamic>? context;
  final int likeCount;
  final int bookmarkCount;
  final int commentCount;
  final bool isLiked;
  final bool isBookmarked;

  Forum({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorRole,
    required this.createdAt,
    required this.context,
    required this.likeCount,
    required this.bookmarkCount,
    required this.commentCount,
    required this.isLiked,
    required this.isBookmarked,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      author: json["author"] ?? "",
      authorRole: json["author_role"] ?? "user",
      createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
      context: json["context"] as Map<String, dynamic>?,
      likeCount: json["like_count"] ?? 0,
      bookmarkCount: json["bookmark_count"] ?? 0,
      commentCount: json["comment_count"] ?? 0,
      isLiked: json["is_liked"] ?? false,
      isBookmarked: json["is_bookmarked"] ?? false,
    );
  }
}
