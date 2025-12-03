import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sportscope_today_mobile/screens/homepage.dart';
import '../screens/login.dart';
import '../screens/register.dart';

class LeftDrawer extends StatelessWidget {
  final bool isAuthenticated;
  final String? username;
  final String? email;
  final String? role;

  const LeftDrawer({
    Key? key,
    this.isAuthenticated = false,
    this.username,
    this.email,
    this.role,
  }) : super(key: key);

  // Get single initial from username
  String _getUserInitial() {
    if (username == null || username!.isEmpty) return 'U';
    return username![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: Container(
        color: const Color(0xFF052962),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x4DFFD700),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: isAuthenticated
                    ? _buildUserProfile()
                    : _buildWelcomeMessage(),
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                children: [
                  // Main Menu Items (4 modul utama)
                  _buildMenuItem(
                    context,
                    title: 'News',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('News page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: 'Matches',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Matches page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: 'Players',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Players page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    title: 'Forum',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Forum page coming soon!'),
                          backgroundColor: Color(0xFF052962),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  const Divider(
                    color: Color(0x4DFFD700),
                    thickness: 1,
                    height: 32,
                  ),

                  // Submenu Items (Categories)
                  _buildSubmenuItem(
                    context,
                    title: 'Transfer',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transfer section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Injury Update',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Injury Update section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Match Result',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Match Result section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Manager News',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Manager News section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Thoughts',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thoughts section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Team Statistics',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Team Statistics section coming soon!')),
                      );
                    },
                  ),
                  _buildSubmenuItem(
                    context,
                    title: 'Hits Player',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hits Player section coming soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Bottom Section - Auth Buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0x4DFFD700),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: isAuthenticated
                    ? _buildSignOutButton(context, request)
                    : _buildAuthButtons(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    // Capitalize username
    String displayName = username?.toUpperCase() ?? 'USER';
    
    return Row(
      children: [
        // Single initial in gold circle
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: Color(0xFFFFD700),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              _getUserInitial(),
              style: const TextStyle(
                color: Color(0xFF052962),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (email != null && email!.isNotEmpty)
                Text(
                  email!,
                  style: const TextStyle(
                    color: Color(0xFFD1D5DB),
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              if (role != null)
                Text(
                  role == 'admin' ? 'Administrator' : 'User',
                  style: const TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Sportscope',
              style: TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Merriweather',
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Merriweather',
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Explore football news & updates',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmenuItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Auth buttons for non-authenticated users
  Widget _buildAuthButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: const Color(0xFF052962),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFFD700),
              side: const BorderSide(color: Color(0xFFFFD700), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(BuildContext context, CookieRequest request) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
          _showLogoutDialog(context, request);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white70),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, CookieRequest request) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                
                try {
                  final response = await request.logout(
                    "https://ahmad-omar-sportscopetoday.pbp.cs.ui.ac.id/api/auth/logout/",
                  );

                  if (context.mounted) {
                    if (response['status'] == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['message'] ?? 'Logged out successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['message'] ?? 'Logout failed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}