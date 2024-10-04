import 'package:flutter/material.dart';
 // Import the main file to use the functions

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            const Padding(
              padding: EdgeInsets.only(top:20.0),
              child: SizedBox(height: 20),
            ),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // Logo Section
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo-no-background.png'), // Replace with your logo path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: SizedBox(height: 40),
            ),
            ElevatedButton(
               onPressed: () {
                Navigator.pushNamed(context, '/login');  // Navigate to booking screen
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.orange,
              ),
            
                  child:const Padding(
                   padding: EdgeInsets.all(10.0), // Correct way to specify top padding
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                
              ),
          ],
        ),
      ),
    );
  }
}
