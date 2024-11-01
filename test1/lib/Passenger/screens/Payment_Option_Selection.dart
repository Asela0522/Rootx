import 'package:flutter/material.dart';
import 'package:test1/Passenger/BUS_SEARCH/search_bus_01.dart';
import 'package:test1/Passenger/QRcode/qr_scan.dart';
import 'package:test1/Passenger/Seat%20booking/SeatBookingScreen1.dart';
// import 'package:test1/Passenger/screens/searchBus.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Removes the debug banner
//       title: 'Payment App',
//       theme: ThemeData(
//         primarySwatch: Colors.orange, // Sets the primary theme color
//       ),
//       home: const PaymentHomeScreen(), // Sets the PaymentHomeScreen as the starting screen
//     );
//   }
// }

class PaymentHomeScreen extends StatelessWidget {
  const  PaymentHomeScreen({super.key}); // Added key for refresh

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF5F5F5), // Light background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome Asela',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 220, 188, 1), // Light orange background
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
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 169, 89, 1), // Orange color for the text background
                      borderRadius: BorderRadius.circular(20), // Rounded box
                    ),
                    child: const Text(
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PaymentButton(
                  icon: Icons.qr_code,
                  label: 'QR Payment',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const QRViewExample()),
                    );
                    // Handle QR Payment
                    // print("QR Payment Clicked");
                  },
                ),
                PaymentButton(
                  icon: Icons.credit_card,
                  label: 'Card Payment',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchBus()),
                    );

                    // Handle Card Payment
                    // print("Card Payment Clicked");
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PaymentButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Consistent width for both boxes
        height: 120, // Consistent height for both boxes
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFFA500), // Orange background for buttons
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white), // Adjusted icon size
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
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
