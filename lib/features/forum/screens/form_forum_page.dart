import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class FormForumPage extends StatefulWidget {
  const FormForumPage({super.key});

  @override
  State<FormForumPage> createState() => _FormForumPageState();
}

class _FormForumPageState extends State<FormForumPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _newsIdController = TextEditingController();
  final _matchIdController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _newsIdController.dispose();
    _matchIdController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final request = context.read<CookieRequest>();

    setState(() => _isSubmitting = true);

    final body = {
      'title': _titleController.text.trim(),
      'content': _contentController.text.trim(),
    };

    if (_newsIdController.text.trim().isNotEmpty) {
      body['news_id'] = _newsIdController.text.trim();
    }
    if (_matchIdController.text.trim().isNotEmpty) {
      body['match_id'] = _matchIdController.text.trim();
    }

    try {
      final res = await request.post(
        'https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/forum/add-forum/',
        body,
      );

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      if (res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Forum berhasil dibuat')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message']?.toString() ?? 'Gagal membuat forum')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Forum Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi forum',
                ),
                maxLines: 6,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Isi forum wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _newsIdController,
                decoration: const InputDecoration(
                  labelText: 'News ID (optional)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _matchIdController,
                decoration: const InputDecoration(
                  labelText: 'Match ID (optional)',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
