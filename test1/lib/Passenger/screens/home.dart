import 'package:flutter/material.dart';
import 'package:test1/Passenger/GPS/Google_Map.dart';
import 'package:test1/Passenger/screens/Payment_Option_Selection.dart';
import 'package:test1/Passenger/screens/busBooking1.dart';
import 'package:test1/Passenger/screens/Profile.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String username = "Asela"; // Placeholder for the username
  int _selectedIndex = 0; // For tracking the selected bottom navigation bar item

  // List of screens to navigate to
  final List<Widget> _screens = [
    const PaymentHomeScreen(), // Home screen
    const BusSelectionScreen(),
    MapScreen(), // Location screen
    const ProfilePage(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index to switch screens
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 169, 89, 1), // Orange color
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/passenger.png'), // User image
              radius: 20, // Slightly larger radius for better visibility
            ),
            const SizedBox(width: 10),
            Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Menu action
            },
          ),
        ],
      ),
      // Display the screen selected by BottomNavigationBar
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(255, 169, 89, 1), // Orange background
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex, // Show the current index
        onTap: _onItemTapped, // Handle tap
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
