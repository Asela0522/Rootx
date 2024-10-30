import 'package:flutter/material.dart';

class SeatBookingScreen3 extends StatelessWidget {
  final List<List<String>> seats;
  const SeatBookingScreen3({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Your Seat'),
        backgroundColor: Colors.orange,
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // Total of 6 columns including the aisle
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 66, // Adjusted for 65 seats plus aisle space
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                int row = index ~/ 6; // Get the row number
                int col = index % 6; // Get the column number

                // Add space after the 2nd column (the aisle)
                if (col == 2) {
                  return const SizedBox(width: 20); // Aisle space
                }

                // Adjust the column index for seats due to the aisle
                int adjustedCol = col > 2 ? col - 1 : col;

                // Calculate seat number based on adjusted row and column
                int seatNumber = (row * 5 + adjustedCol + 1);

                String seatStatus = seats[row][adjustedCol];

                return Container(
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
                      seatNumber.toString(), // Display the seat number
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle seat confirmation logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Seats Confirmed!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Button color
              ),
              child: const Text('Confirm Booking'),
            ),
          ),
        ],
      ),
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
