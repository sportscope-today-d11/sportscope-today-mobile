import 'package:flutter/material.dart';
import 'package:sportscope_today_mobile/authentication/login.dart';
import 'package:sportscope_today_mobile/features/forum/screens/forum_list.dart'; // ⬅️ TAMBAHAN
import 'package:sportscope_today_mobile/features/matches/screens/match_history.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? username;
  final String? role;
  final bool isAuthenticated;

  const CustomAppBar({
    Key? key,
    this.username,
    this.role,
    this.isAuthenticated = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(172); // Slightly increased for dividers

  // Get single initial from username
  String _getUserInitial() {
    if (username == null || username!.isEmpty) return 'U';
    return username![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF052962),
      child: Column(
        children: [
          // Main AppBar with Logo & Auth
          SafeArea(
            bottom: false,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Hamburger Menu
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // Logo Text
                  const Text(
                    'Sportscope',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Today',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Auth Button or User Initial Icon
                  if (isAuthenticated)
                    // Show single initial when logged in
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _getUserInitial(),
                          style: const TextStyle(
                            color: Color(0xFF052962),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    // Show Sign In button
                    ElevatedButton(
                      onPressed: () {
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Divider sebelum main menu (agak tegas)
          Container(
            height: 2,
            color: const Color(0xFF031a42).withOpacity(0.8),
          ),
          
          // Main Navigation Menu (4 modul utama)
          Container(
            height: 50,
            color: const Color(0xFF052962),
            child: Row(
              children: [
                _MainMenuItem(
                  label: 'NEWS',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('News coming soon!')),
                    );
                  },
                ),
                // Vertical divider between items
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.white.withOpacity(0.2),
                ),
                _MainMenuItem(
                  label: 'MATCHES',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MatchHistoryPage()),
                    );
                  },
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.white.withOpacity(0.2),
                ),
                _MainMenuItem(
                  label: 'PLAYERS',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Players coming soon!')),
                    );
                  },
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.white.withOpacity(0.2),
                ),
                _MainMenuItem(
                  label: 'FORUM',
                  onPressed: () {
                    // ROUTING KE HALAMAN FORUM LIST
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForumListPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Divider setelah main menu sebelum scrollable (tipis)
          Container(
            height: 1,
            color: const Color(0xFF031a42).withOpacity(0.5),
          ),
          
          // Scrollable Sub-Menu (Categories)
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF031a42),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _SubMenuItem(
                    label: 'Transfer',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transfer news coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Injury Update',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Injury updates coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Match Result',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Match results coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Manager News',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Manager news coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Thoughts',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thoughts coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Team Statistics',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Team statistics coming soon!')),
                      );
                    },
                  ),
                  _SubMenuItem(
                    label: 'Hits Player',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hit players coming soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Main Menu Item (NEWS, MATCHES, etc.)
class _MainMenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _MainMenuItem({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// Sub-Menu Item Widget
class _SubMenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _SubMenuItem({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
