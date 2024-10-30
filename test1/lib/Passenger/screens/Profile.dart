import 'package:flutter/material.dart';
// import 'package:project_user_profile/Page/notifications_page.dart';
// import 'package:project_user_profile/page/edit_profile_page.dart';
// import 'package:project_user_profile/page/logout_page.dart';
// import 'package:project_user_profile/page/payments_page.dart';
// import 'package:project_user_profile/page/privacy_page.dart';

void main() {
  runApp(const MyApp());
}

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
        // '/editProfile': (context) => const EditProfilePage(),
        // '/notifications': (context) => const NotificationsPage(),
        // '/privacy': (context) => const PrivacyPage(),
        // '/payments': (context) => const PaymentsPage(),
        // '/logout': (context) => const LogoutPage(),
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
    // const HomePage(),
    // const BusPage(),
    // const LocationPage(),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Color.fromARGB(255, 176, 174, 174),
      //   backgroundColor: Colors.orange, // Set background color to orange
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.directions_bus),
      //       label: 'Bus',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.location_on),
      //       label: 'Location',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.orange,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     iconSize: 33,
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: const Row(
      //     children: <Widget>[
      //       CircleAvatar(
      //         backgroundImage: AssetImage('assets/passenger.png'),
      //         radius: 22,
      //       ),
      //       SizedBox(width: 10),
      //       Text(
      //         'Profile',
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 25,
      //         ),
      //         strutStyle: StrutStyle(
      //           fontSize: 20,
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.menu),
      //       iconSize: 33,
      //       onPressed: () {
      //         // Add menu functionality here
      //       },
      //     ),
      //   ],
      // ),
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
                      Navigator.pushNamed(context, '/logout');
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

// // Sample page for Home
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const ProfilePage()),
//               (Route<dynamic> route) => false, // Removes all previous routes
//             );
//           },
//         ),
//       ),
//       body: const Center(
//         child: Text('Home Page'),
//       ),
//     );
//   }
// }
//
// // // Sample page for Bus
// class BusPage extends StatefulWidget {
//   const BusPage({super.key});
//
//   @override
//   State<BusPage> createState() => _BusPageState();
// }
//
// class _BusPageState extends State<BusPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bus Page'),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const ProfilePage()),
//               (Route<dynamic> route) => false, // Removes all previous routes
//             );
//           },
//         ),
//       ),
//       body: const Center(
//         child: Text('Bus Page'),
//       ),
//     );
//   }
// }
//
// // Sample page for Location
// class LocationPage extends StatefulWidget {
//   const LocationPage({super.key});
//
//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Page'),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navigate back to ProfilePage
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const ProfilePage()),
//               (Route<dynamic> route) => false, // Removes all previous routes
//             );
//           },
//         ),
//       ),
//       body: const Center(
//         child: Text('Location Page'),
//       ),
//     );
//   }
// }
