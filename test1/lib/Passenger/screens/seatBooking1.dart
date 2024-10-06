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
      home: SeatBookingScreen(),
    );
  }
}

class SeatBookingScreen extends StatefulWidget {
  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  final List<Widget> _screens = [
    SeatBooking(),
    BusScreen(),
    LocationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
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
            // Handle back navigation (if needed)
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action (if needed)
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex, // Use the correct selected index
        onTap: _onItemTapped, // Call the method to update index on tap
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Define these placeholder widgets for the screens used in _screens
class BusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Bus Screen')),
    );
  }
}

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Location Screen')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Profile Screen')),
    );
  }
}

class SeatBooking extends StatefulWidget {
  @override
  _SeatBookingState createState() => _SeatBookingState();
}

class _SeatBookingState extends State<SeatBooking> {
  // Example list to indicate seat status
  List<bool> seatAvailability =
  List.generate(20, (index) => index % 5 != 0); // Seats available except every 5th seat
  List<bool> selectedSeats =
  List.generate(20, (index) => false); // Initially, no seats selected

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Indicator(color: Colors.blue, label: 'Selected'),
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
                    buildSeatsGrid(2),
                  ],
                ),
                const SizedBox(width: 50), // Space between two seat grids
                // Right side with 3 columns
                Column(
                  children: [
                    buildSeatsGrid(3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSeatsGrid(int columns) {
    double seatWidth = 37.0; // Adjust the width of the seats here
    double seatHeight = 37.0; // Adjust the height of the seats here
    double seatSpacing = 10.0; // Adjust the spacing between seats here

    return Column(
      children: List.generate(10, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(columns, (colIndex) {
            int seatIndex = rowIndex * columns + colIndex; // Calculate seat index

            bool isBooked = !seatAvailability[seatIndex]; // Check if the seat is booked
            bool isSelected = selectedSeats[seatIndex]; // Check if the seat is selected

            return Padding(
              padding: EdgeInsets.all(seatSpacing / 2), // Space between seats
              child: GestureDetector(
                onTap: () {
                  if (!isBooked) {
                    setState(() {
                      selectedSeats[seatIndex] = !isSelected; // Toggle seat selection
                    });
                  }
                },
                child: Container(
                  width: seatWidth,
                  height: seatHeight,
                  decoration: BoxDecoration(
                    color: isBooked
                        ? Color.fromARGB(255, 226, 220, 220) // Booked seats color
                        : (isSelected ? Colors.blue : Colors.green), // Selected or available color
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
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
