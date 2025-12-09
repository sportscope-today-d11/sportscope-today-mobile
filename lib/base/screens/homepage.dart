import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';
import '../widgets/app_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String? username;
  final String? role;
  final String? email;

  const HomePage({
    Key? key,
    this.username,
    this.role,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final bool isAuthenticated = request.loggedIn && username != null;

    return Scaffold(
      appBar: CustomAppBar(
        username: username,
        role: role,
        isAuthenticated: isAuthenticated,
      ),
      drawer: LeftDrawer(
        isAuthenticated: isAuthenticated,
        username: username,
        email: email,
        role: role,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Homepage Content Coming Soon',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}