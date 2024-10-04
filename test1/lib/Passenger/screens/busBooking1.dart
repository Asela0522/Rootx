import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Booking App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BusSelectionScreen(),
    );
  }
}

class BusSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> buses = [
    {'name': 'Superline', 'price': 450, 'seats': 25, 'time': '2:30 pm'},
    {'name': 'Eagle Transport', 'price': 450, 'seats': 18, 'time': '3:00 pm'},
    {'name': 'Intercity Express', 'price': 450, 'seats': 15, 'time': '3:30 pm'},
    {'name': 'Superline', 'price': 450, 'seats': 6, 'time': '4:00 pm'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {/* Handle back navigation */},
        ),
        title: Text('Book Your Seat'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {/* Handle menu action */},
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Search Bus', style: TextStyle(color: Colors.orange)),
                Text('Select Bus', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Payment'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, index) {
                return BusCard(bus: buses[index]);
              },
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
}

class BusCard extends StatelessWidget {
  final Map<String, dynamic> bus;

  const BusCard({Key? key, required this.bus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.directions_bus, color: Colors.orange),
                const SizedBox(width: 8),
                Text(bus['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Price', 'Rs.${bus['price']}'),
                _buildInfoColumn('Available Seats', '${bus['seats']}'),
                _buildInfoColumn('Time', bus['time']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}