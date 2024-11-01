import 'package:flutter/material.dart';


// Main App class converted to StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(), // Main page with Bottom Navigation

      },
    );
  }
}

// Main Page with Bottom Navigation Bar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define pages corresponding to the icons
  final List<Widget> _pages = [
    const ProfilePage(), // Profile Page with buttons to navigate to other pages
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // Add more items as needed
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Profile Page as StatefulWidget
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.person,
                    text: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.notifications,
                    text: 'Notifications',
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.security,
                    text: 'Privacy',
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.payment,
                    text: 'Payments',
                    onTap: () {
                      Navigator.pushNamed(context, '/payments');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.power_settings_new,
                    text: 'Logout',
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for building buttons on the profile page
Widget _buildProfileButton({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    ),
  );
}
