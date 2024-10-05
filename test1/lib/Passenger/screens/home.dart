import 'package:flutter/material.dart';

void main() => runApp(RootXApp());

class RootXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String username = "UserName"; // Placeholder for the username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 169, 89, 1), // Orange color
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/passenger.png'), // Placeholder for the user image
            ),
            SizedBox(width: 10),
            Text(username),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Menu action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'WELCOME $username!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    Color.fromRGBO(255, 220, 188, 1), // Light orange background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo-no-background.png', // Replace with your image path
                    width: 100, // Set the desired width
                    height: 100, // Set the desired height
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 169, 89,
                          1), // Orange color for the text background
                      borderRadius: BorderRadius.circular(20), // Rounded box
                    ),
                    child: Text(
                      'Select Your Payment Method',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PaymentButton(
                  icon: Icons.qr_code,
                  label: 'QR Payment',
                  onTap: () {
                    // Handle QR Payment
                    print("QR Payment Clicked");
                  },
                ),
                PaymentButton(
                  icon: Icons.credit_card,
                  label: 'Card Payment',
                  onTap: () {
                    // Handle Card Payment
                    print("Card Payment Clicked");
                  },
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            const Color.fromRGBO(255, 169, 89, 1), // Orange background
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  PaymentButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Consistent width for both boxes
        height: 120, // Consistent height for both boxes
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xFFFFA500), // Orange background for buttons
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white), // Adjusted icon size
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14, // Adjusted text size
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // Centered text
            ),
          ],
        ),
      ),
    );
  }
}
