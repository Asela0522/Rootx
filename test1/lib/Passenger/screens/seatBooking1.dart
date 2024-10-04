import 'package:flutter/material.dart';
import 'seatBooking2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seat Booking',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SeatBookingScreen(),
    );
  }
}

class SeatBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Seat'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Indicator(color: Colors.green, label: 'Available'),
                const SizedBox(width: 20),
                Indicator(color: Color.fromARGB(255, 226, 220, 220), label: 'Booked'),
                const SizedBox(width: 20),
                Indicator(color: Color.fromARGB(255, 226, 220, 220), label: 'Selected'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left side with 2 columns
                  Column(
                    children: [
                      buildSeatsGrid(2, Colors.green, Color.fromARGB(255, 226, 220, 220)),
                    ],
                  ),
                  const SizedBox(width: 50), // Space between two seat grids
                  // Right side with 3 columns
                  Column(
                    children: [
                      buildSeatsGrid(3, Colors.green, Color.fromARGB(255, 226, 220, 220)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildSeatsGrid(int columns, Color availableColor, Color bookedColor) {
    double seatWidth = 37.0; // Adjust the width of the seats here
    double seatHeight = 37.0; // Adjust the height of the seats here
    double seatSpacing = 10.0; // Adjust the spacing between seats here

    return Column(
      children: List.generate(10, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(columns, (colIndex) {
            bool isBooked = (rowIndex + colIndex) % 5 == 0; // Example logic for booked seats

            return Padding(
              padding: EdgeInsets.all(seatSpacing / 2), // Space between seats
              child: Container(
                width: seatWidth,
                height: seatHeight,
                decoration: BoxDecoration(
                  color: isBooked ? bookedColor : availableColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String label;

  Indicator({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
