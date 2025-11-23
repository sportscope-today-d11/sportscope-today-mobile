import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../screens/login.dart';

class LeftDrawer extends StatelessWidget {
  final bool isAuthenticated;
  final String? username;
  final String? email;
  final String? role;

  const LeftDrawer({
    Key? key,
    required this.isAuthenticated,
    this.username,
    this.email,
    this.role,
  }) : super(key: key);

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
                    title: role == 'admin' ? 'Manage Matches' : 'Matches',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${role == 'admin' ? 'Manage ' : ''}Matches page coming soon!'),
                          backgroundColor: const Color(0xFF052962),
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

                  // Submenu Items
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

            // Bottom Section
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
                    : _buildSignInButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: const Icon(
            Icons.person,
            size: 28,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username ?? 'User',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome!',
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Merriweather',
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Explore the latest football news & updates',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 14,
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
            fontFamily: 'Lato',
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
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Lato',
          ),
        ),
      ),
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
          side: const BorderSide(color: Colors.grey),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Lato',
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
                Navigator.pop(dialogContext); // Close dialog
                
                try {
                  // TODO: Ganti dengan URL Django Anda
                  final response = await request.logout(
                    "http://localhost:8000/auth/logout/",
                  );

                  if (context.mounted) {
                    if (response['status'] == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['message'] ?? 'Logged out successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Navigate to login page and remove all previous routes
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
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
                      const SnackBar(
                        content: Text('An error occurred during logout'),
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