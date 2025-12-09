import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../../base/widgets/app_bar.dart';
import '../../../base/widgets/left_drawer.dart';
import '../widgets/forum_card.dart';
import 'forum_detail.dart';
import 'form_forum_page.dart';
import '../models/forum_entry.dart';

class ForumListPage extends StatefulWidget {
  const ForumListPage({super.key});

  @override
  State<ForumListPage> createState() => _ForumListPageState();
}

class _ForumListPageState extends State<ForumListPage> {
  bool _isLoading = true;
  String? _error;
  List<Forum> _forums = [];

  static const String baseUrl = "http://127.0.0.1:8000/api/forum/";

  @override
  void initState() {
    super.initState();
    _loadForums();
  }

  Future<void> _loadForums() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final request = context.read<CookieRequest>();

    try {
      final response = await request.get("${baseUrl}forums/");

      final List<dynamic> forumsJson = response['forums'] ?? [];

      setState(() {
        _forums = forumsJson
            .map((e) => Forum.fromJson(e as Map<String, dynamic>))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLike(Forum forum) async {
    final request = context.read<CookieRequest>();
    try {
      final res = await request.post(
        "${baseUrl}like/",
        {'forum_id': forum.id},
      );

      if (!mounted) return;

      setState(() {
        _forums = _forums.map((f) {
          if (f.id == forum.id) {
            return Forum(
              id: f.id,
              title: f.title,
              content: f.content,
              author: f.author,
              authorRole: f.authorRole,
              createdAt: f.createdAt,
              context: f.context,
              likeCount: res['like_count'] ?? f.likeCount,
              bookmarkCount: f.bookmarkCount,
              commentCount: f.commentCount,
              isLiked: (res['status'] == 'liked'),
              isBookmarked: f.isBookmarked,
            );
          }
          return f;
        }).toList();
      });
    } catch (_) {}
  }

  Future<void> _toggleBookmark(Forum forum) async {
    final request = context.read<CookieRequest>();
    try {
      final res = await request.post(
        "${baseUrl}add-bookmart/",
        {'forum_id': forum.id},
      );

      if (!mounted) return;

      setState(() {
        _forums = _forums.map((f) {
          if (f.id == forum.id) {
            return Forum(
              id: f.id,
              title: f.title,
              content: f.content,
              author: f.author,
              authorRole: f.authorRole,
              createdAt: f.createdAt,
              context: f.context,
              likeCount: f.likeCount,
              bookmarkCount: res['bookmark_count'] ?? f.bookmarkCount,
              commentCount: f.commentCount,
              isLiked: f.isLiked,
              isBookmarked: (res['status'] == 'added'),
            );
          }
          return f;
        }).toList();
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    final bool isAuthenticated = request.loggedIn;
    final String? username = request.jsonData['username'] as String?;
    final String? role = request.jsonData['role'] as String?;

    return Scaffold(
      appBar: CustomAppBar(
        username: username,
        role: role,
        isAuthenticated: isAuthenticated,
      ),
      drawer: LeftDrawer(
        isAuthenticated: isAuthenticated,
        username: username,
        role: role,
      ),
      body: RefreshIndicator(
        onRefresh: _loadForums,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : _forums.isEmpty
                    ? const Center(child: Text('Belum ada forum.'))
                    : ListView.builder(
                        itemCount: _forums.length,
                        itemBuilder: (context, index) {
                          final forum = _forums[index];
                          return ForumCard(
                            forum: forum,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForumDetailPage(
                                    forumId: forum.id,
                                    initialForum: forum,
                                  ),
                                ),
                              );
                            },
                            onLike: isAuthenticated
                                ? () => _toggleLike(forum)
                                : null,
                            onBookmark: isAuthenticated
                                ? () => _toggleBookmark(forum)
                                : null,
                          );
                        },
                      ),
      ),
      floatingActionButton: isAuthenticated
          ? FloatingActionButton(
              onPressed: () async {
                final created = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormForumPage(),
                  ),
                );
                if (created == true) _loadForums();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
