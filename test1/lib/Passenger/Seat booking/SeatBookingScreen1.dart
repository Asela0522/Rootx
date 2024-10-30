import 'package:flutter/material.dart';
import 'package:test1/Passenger/Seat booking/SeatBookingScreen2.dart'; // Import SeatBookingScreen2

class SeatBookingScreen1 extends StatefulWidget {
  const SeatBookingScreen1({super.key});

  @override
  _SeatBookingScreen1State createState() => _SeatBookingScreen1State();
}

class _SeatBookingScreen1State extends State<SeatBookingScreen1> {
  List<List<String>> seats =
      List.generate(11, (i) => List.generate(5, (j) => 'available'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Seat'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildIndicator(Colors.green, 'Available'),
                const SizedBox(width: 10),
                buildIndicator(Colors.red, 'Booked'),
                const SizedBox(width: 10),
                buildIndicator(Colors.orange, 'Selected'),
              ],
            ),
          ),
          Expanded(
            child: buildSeatsGrid(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Check if at least one seat is selected
                bool isAnySeatSelected =
                    seats.any((row) => row.contains('selected'));

                if (isAnySeatSelected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatBookingScreen2(seats: seats),
                    ),
                  );
                } else {
                  // Show a message if no seats are selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select at least one seat.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeatsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 66,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        int row = index ~/ 6;
        int col = index % 6;

        if (col == 2) {
          return const SizedBox(width: 0);
        }

        int adjustedCol = col > 2 ? col - 1 : col;

        if (row >= seats.length || adjustedCol >= seats[row].length) {
          return const SizedBox();
        }

        String seatNumber = (row * 5 + adjustedCol + 1).toString();
        String seatStatus = seats[row][adjustedCol];

        return GestureDetector(
          onTap: () {
            setState(() {
              if (seatStatus == 'available') {
                seats[row][adjustedCol] = 'selected';
              }
            });
          },
          onDoubleTap: () {
            setState(() {
              if (seatStatus == 'selected') {
                seats[row][adjustedCol] = 'available';
              }
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: seatStatus == 'available'
                  ? Colors.green
                  : seatStatus == 'booked'
                      ? Colors.red
                      : Colors.orange,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                seatNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildIndicator(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
