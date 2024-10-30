import 'package:flutter/material.dart';
import 'package:test1/Passenger/Seat booking/SeatBookingScreen3.dart';

class SeatBookingScreen2 extends StatelessWidget {
  final List<List<String>> seats;
  const SeatBookingScreen2({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Overview'),
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
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // Total of 6 columns including aisle
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 66, // Adjusted to 66 for 65 seats plus aisle spaces
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                int row = index ~/ 6; // Get the row number
                int col = index % 6; // Get the column number

                // Create the aisle by skipping the 3rd column (index 2)
                if (col == 2) {
                  return const SizedBox(width: 20); // Add aisle space
                }

                // Adjust the column index for seats due to aisle
                int adjustedCol = col > 2 ? col - 1 : col;

                // Calculate the seat number based on adjusted row and column
                int seatNumber = (row * 5 + adjustedCol + 1);

                // Get seat status
                String seatStatus = seats[row][adjustedCol];

                return Container(
                  decoration: BoxDecoration(
                    color:
                        seatStatus == 'available' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      seatNumber.toString(), // Display seat number
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
                // Navigate to the third screen (confirmation interface)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeatBookingScreen3(seats: seats)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.orange, // Set the button color to orange
              ),
              child: const Text('Confirm'),
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
