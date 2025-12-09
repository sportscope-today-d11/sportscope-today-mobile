import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../widgets/forum_card.dart';
import '../widgets/comment_card.dart';
import '../models/comment_entry.dart';
import '../models/forum_entry.dart';

class ForumDetailPage extends StatefulWidget {
  final String forumId;
  final Forum? initialForum;

  const ForumDetailPage({
    super.key,
    required this.forumId,
    this.initialForum,
  });

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  Forum? _forum;
  List<ForumComment> _comments = [];
  bool _isLoadingForum = true;
  bool _isLoadingComments = true;
  String? _error;

  final TextEditingController _commentController = TextEditingController();
  ForumComment? _replyTarget;

  @override
  void initState() {
    super.initState();
    _forum = widget.initialForum;
    _loadForum();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadForum() async {
    setState(() => _isLoadingForum = true);
    final request = context.read<CookieRequest>();

    try {
      final res = await request
          .get('https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/forum/${widget.forumId}/');

      if (!mounted) return;

      if (res['success'] == true) {
        final f = Forum.fromJson(res['forum'] as Map<String, dynamic>);
        setState(() {
          _forum = f;
          _isLoadingForum = false;
        });
      } else {
        setState(() {
          _error = res['message']?.toString();
          _isLoadingForum = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoadingForum = false;
      });
    }
  }

  Future<void> _loadComments() async {
    setState(() => _isLoadingComments = true);
    final request = context.read<CookieRequest>();

    try {
      final res = await request
          .get('https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/forum/${widget.forumId}/comments/');

      if (!mounted) return;

      if (res['success'] == true) {
        final List<dynamic> list = res['comments'] ?? [];
        setState(() {
          _comments = list
              .map((e) =>
                  ForumComment.fromJson(e as Map<String, dynamic>))
              .toList();
          _isLoadingComments = false;
        });
      } else {
        setState(() {
          _error = res['message']?.toString();
          _isLoadingComments = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoadingComments = false;
      });
    }
  }

  Future<void> _sendComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final request = context.read<CookieRequest>();
    final body = {
      'text': _commentController.text.trim(),
    };
    if (_replyTarget != null) {
      body['reply_to_comment_id'] = _replyTarget!.id;
    }

    try {
      final res = await request.post(
        'https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/forum/${widget.forumId}/add-comment/',
        body,
      );

      if (!mounted) return;

      if (res['success'] == true) {
        _commentController.clear();
        setState(() => _replyTarget = null);
        _loadComments();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['message']?.toString() ?? 'Gagal mengirim komentar'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final forum = _forum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Forum'),
      ),
      body: _error != null
          ? Center(child: Text('Error: $_error'))
          : _isLoadingForum && forum == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    if (forum != null)
                      ForumCard(
                        forum: forum,
                        onTap: null,
                      ),
                    const Divider(),
                    Expanded(
                      child: _isLoadingComments
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _comments.isEmpty
                              ? const Center(
                                  child: Text('Belum ada komentar.'),
                                )
                              : ListView.builder(
                                  itemCount: _comments.length,
                                  itemBuilder: (context, index) {
                                    final c = _comments[index];
                                    return CommentCard(
                                      comment: c,
                                      onReply: (target) {
                                        setState(() => _replyTarget = target);
                                      },
                                    );
                                  },
                                ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          if (_replyTarget != null)
                            Expanded(
                              child: Text(
                                'Reply to @${_replyTarget!.author}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() => _replyTarget = null);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: 'Tulis komentar...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _sendComment,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
