import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username;
  final String role;
  final String? email;

  const HomePage({
    Key? key,
    required this.username,
    required this.role,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Sportscope',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'Today',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF052962),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(
        isAuthenticated: request.loggedIn,
        username: username,
        email: email,
        role: role,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF052962), Color(0xFF031a42)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, $username!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Role: ${role == 'admin' ? 'Administrator' : 'User'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your one-stop destination for football news & updates',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Quick Access Section
              const Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF052962),
                ),
              ),
              const SizedBox(height: 16),

              // Menu Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  MenuCard(
                    title: 'News',
                    icon: Icons.newspaper,
                    color: const Color(0xFF052962),
                    onTap: () {
                      // TODO: Navigate to News page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('News page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  MenuCard(
                    title: role == 'admin' ? 'Manage Matches' : 'Matches',
                    icon: role == 'admin' ? Icons.admin_panel_settings : Icons.sports_soccer,
                    color: const Color(0xFF052962),
                    onTap: () {
                      // TODO: Navigate to Matches page
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${role == 'admin' ? 'Manage ' : ''}Matches page coming soon!'),
                          backgroundColor: const Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  MenuCard(
                    title: 'Players',
                    icon: Icons.people,
                    color: const Color(0xFF052962),
                    onTap: () {
                      // TODO: Navigate to Players page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Players page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  MenuCard(
                    title: 'Forum',
                    icon: Icons.forum,
                    color: const Color(0xFF052962),
                    onTap: () {
                      // TODO: Navigate to Forum page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Forum page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Categories Section
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF052962),
                ),
              ),
              const SizedBox(height: 16),

              // Categories List
              CategoryTile(
                title: 'Transfer News',
                icon: Icons.swap_horiz,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transfer News coming soon!')),
                  );
                },
              ),
              CategoryTile(
                title: 'Injury Updates',
                icon: Icons.local_hospital,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Injury Updates coming soon!')),
                  );
                },
              ),
              CategoryTile(
                title: 'Match Results',
                icon: Icons.emoji_events,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Match Results coming soon!')),
                  );
                },
              ),
              CategoryTile(
                title: 'Manager News',
                icon: Icons.person_outline,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manager News coming soon!')),
                  );
                },
              ),
              CategoryTile(
                title: 'Team Statistics',
                icon: Icons.bar_chart,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Team Statistics coming soon!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color(0xFFFFD700)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF052962).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF052962)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}