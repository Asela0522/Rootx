import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: busData.length,
        itemBuilder: (context, index) {
          final bus = busData[index];
          return Card(
            child: ListTile(
              title: Text(bus['Bus_Name']),
              subtitle: Text('From: ${bus['Start_Location']} To: ${bus['End_Location']}'),
              trailing: Text('\$${bus['Ticket_Price']}'),
            ),
          );
        },
      ),
    );
  }
}
