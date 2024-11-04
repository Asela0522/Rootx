import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Seat booking/test02.dart'; // Import intl package for number formatting
// import 'package:test1/Passenger/Seat%20booking/SeatBookingScreen1.dart';


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
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: busData.length,
          itemBuilder: (context, index) {
            final bus = busData[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
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
                        Text('From: ${bus['Start_Location']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text('To: ${bus['End_Location']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text('Start Time: ${bus['Start_Time']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.event_seat, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          'Available Seats: ${bus['Available_Seats']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Text(
                  'LKR ${NumberFormat('#,##0').format(bus['Ticket_Price'])}',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusBookingScreen(busData: bus),
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
