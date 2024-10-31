import 'package:flutter/material.dart';
import 'package:test1/Passenger/Seat booking/SeatBookingScreen1.dart';
import 'package:intl/intl.dart'; // Import intl package for number formatting

class BusSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> busData;

  const BusSelectionScreen({
    Key? key,
    required this.busData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Selection'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.grey[200], // Background color for the screen
        child: ListView.builder(
          itemCount: busData.length,
          itemBuilder: (context, index) {
            final bus = busData[index];
            return Card(
              elevation: 5, // Add elevation for depth
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0), // Padding inside the card
                title: Text(
                  bus['Bus_Name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text('From: ${bus['Start_Location']}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text('To: ${bus['End_Location']}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text('Start Time: ${bus['Start_Time']}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                trailing: Text(
                  'LKR ${NumberFormat('#,##0').format(bus['Ticket_Price'])}', // Format price as LKR
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to the SeatBookingScreen1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatBookingScreen1(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
