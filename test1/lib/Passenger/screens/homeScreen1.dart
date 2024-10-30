import 'package:flutter/material.dart';
import 'package:test1/Passenger/main/main.dart'; // Import the main file to use the functions

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(  // Wrap the entire body in a SafeArea to avoid padding issues
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Bus Image with Curved Border
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50), 
                  bottomRight: Radius.circular(50)), // Adjust the radius as needed
                child: Image.asset(
                  'assets/images/busNew.png', // Replace with your asset path
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Welcome text
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            const Text(
              'Please select the correct option to move forward',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Driver and Passenger options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Driver option
                GestureDetector(
                  onTap: () {
                    handleDriverSelection(context);  // Call function from main.dart
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange,  // Border color
                            width: 3,  // Border width
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/driver.png'),  // Replace with your asset path
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Driver',
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                // Passenger option
                GestureDetector(
                  onTap: () {
                    handlePassengerSelection(context);  // Call function from main.dart
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange,  // Border color
                            width: 3,  // Border width
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/passenger.png'),  // Replace with your asset path
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Passenger',
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Next Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/welcome');  // Navigate to booking screen
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.orange,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 40),  // Space between button and bottom
          ],
        ),
      ),
    );
  }
}
