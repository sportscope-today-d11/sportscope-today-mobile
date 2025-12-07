import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';
import '../widgets/left_drawer.dart';
import '../widgets/news_card.dart';
import '../models/news_entry.dart';
import 'news_detail.dart';

class NewsListPage extends StatefulWidget {
  final String? category;

  const NewsListPage({super.key, this.category});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<News> _list = [];
  bool _isLoading = true;
  String? _error;
  String? _category;

  int _page = 1;
  String _sort = 'latest';

  @override
  void initState() {
    super.initState();
    _category = widget.category;
    _loadNews();
  }

  Future<void> _loadNews() async {
    final request = context.read<CookieRequest>();
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final res = await request.get(
        'https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/news/?page=$_page&sort=$_sort${_category != null ? '&category=$_category' : ''}',
      );

      final List<dynamic> jsonList = res['news'] as List;

      setState(() {
        _list = jsonList.map((e) => News.fromJson(e)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleBookmark(News news) async {
    final request = context.read<CookieRequest>();
    await request.post(
      'https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/news/${news.id}/bookmark/',
      {},
    );
    _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final isAuth = request.loggedIn;
    final username = request.jsonData['username'];

    return Scaffold(
      appBar: CustomAppBar(
        username: username,
        role: request.jsonData['role'],
        isAuthenticated: isAuth,
      ),
      drawer: LeftDrawer(
        isAuthenticated: isAuth,
        username: username,
        role: request.jsonData['role'],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Text('Sort: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _sort,
                  items: const [
                    DropdownMenuItem(
                        value: 'latest', child: Text('Latest')),
                    DropdownMenuItem(
                        value: 'oldest', child: Text('Oldest')),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _sort = v);
                    _loadNews();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text('Error: $_error'))
                : RefreshIndicator(
              onRefresh: _loadNews,
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final news = _list[i];
                  return NewsCard(
                    news: news,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailPage(
                            id: news.id.toString(),
                          ),
                        ),
                      );
                    },
                    onBookmark: () => _toggleBookmark(news),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _page > 1
                    ? () {
                  setState(() => _page--);
                  _loadNews();
                }
                    : null,
                child: const Text('Prev'),
              ),
              Text('Page $_page'),
              TextButton(
                onPressed: () {
                  setState(() => _page++);
                  _loadNews();
                },
                child: const Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
