import 'package:flutter/material.dart';

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
      home: SeatBooking2(),
    );
  }
}

class SeatBooking2 extends StatefulWidget {
  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBooking2> {
  final int rows = 10;
  final int columnsLeft = 2;
  final int columnsRight = 3;

  // Define the seat states here: 'available', 'booked', 'selected'
  List<List<String>> seatStates = [
    // Left grid
    ['available', 'booked'],
    ['booked', 'available'],
    ['available', 'available'],
    ['booked', 'available'],
    ['available', 'booked'],
    ['available', 'available'],
    ['booked', 'booked'],
    ['available', 'available'],
    ['available', 'booked'],
    ['booked', 'available'],
    // Right grid
    ['available', 'booked', 'available'],
    ['booked', 'available', 'available'],
    ['available', 'available', 'booked'],
    ['available', 'available', 'available'],
    ['booked', 'available', 'booked'],
    ['available', 'booked', 'available'],
    ['available', 'available', 'available'],
    ['booked', 'available', 'booked'],
    ['available', 'available', 'available'],
    ['booked', 'available', 'booked'],
  ];

  void toggleSeatSelection(int rowIndex, int colIndex, bool isLeftGrid) {
    setState(() {
      int startIndex = isLeftGrid ? 0 : rows;
      int seatIndex = startIndex + rowIndex;
      String currentState = seatStates[seatIndex][colIndex];

      if (currentState == 'available') {
        seatStates[seatIndex][colIndex] = 'selected';
      } else if (currentState == 'selected') {
        seatStates[seatIndex][colIndex] = 'available';
      }
    });
  }

  void confirmBooking() {
    // Implement your booking confirmation logic here
    // For now, this is just a placeholder
    print('Booking confirmed!');
  }

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
                Indicator(color: Colors.red, label: 'Booked'),
                const SizedBox(width: 20),
                Indicator(color: Colors.yellow, label: 'Selected'),
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
                      buildSeatsGrid(columnsLeft, true),
                    ],
                  ),
                  const SizedBox(width: 50), // Space between two seat grids
                  // Right side with 3 columns
                  Column(
                    children: [
                      buildSeatsGrid(columnsRight, false),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
            child: SizedBox(
              width: 200.0, // Button will take full width of the screen
              height: 30.0, // Set desired height for the button
              child: ElevatedButton(
                onPressed: confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16,color: Colors.black,)
                ),
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

  Widget buildSeatsGrid(int columns, bool isLeftGrid) {
    double seatWidth = 33.0; // Adjust the width of the seats here
    double seatHeight = 33.0; // Adjust the height of the seats here
    double seatSpacing = 8.0; // Adjust the spacing between seats here

    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(columns, (colIndex) {
            // Determine the index in the seatStates list
            int startIndex = isLeftGrid ? 0 : rows;
            int seatIndex = startIndex + rowIndex;
            String seatState = seatStates[seatIndex][colIndex];

            // Determine the color based on seat state
            Color seatColor;
            if (seatState == 'booked') {
              seatColor = Colors.red;
            } else if (seatState == 'selected') {
              seatColor = Colors.yellow;
            } else {
              seatColor = Colors.green;
            }

            return GestureDetector(
              onTap: () => toggleSeatSelection(rowIndex, colIndex, isLeftGrid),
              child: Padding(
                padding: EdgeInsets.all(seatSpacing / 2), // Space between seats
                child: Container(
                  width: seatWidth,
                  height: seatHeight,
                  decoration: BoxDecoration(
                    color: seatColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
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
