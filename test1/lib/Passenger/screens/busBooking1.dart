import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/bus_api.dart';  // Import your backend connectivity here.

class BusSelectionScreen extends StatefulWidget {
  const BusSelectionScreen({super.key});

  @override
  _BusSelectionScreenState createState() => _BusSelectionScreenState();
}

class _BusSelectionScreenState extends State<BusSelectionScreen> {
  List<dynamic> buses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBusData();
  }

  Future<void> fetchBusData() async {
    var busData = await BusApi.getBusInformation(); // Call the backend API here.
    setState(() {
      buses = busData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: buses.length,
        itemBuilder: (context, index) {
          return BusCard(bus: buses[index]);
        },
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
                Text(bus['Bus_Name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Price', 'Rs.${bus['Ticket_Price']}'),
                _buildInfoColumn('Seats', '${bus['Total_Seats']}'),
                _buildInfoColumn('Time', bus['Start_Time']),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Route', bus['Route_Number']),
                _buildInfoColumn('Start', bus['Start_Location']),
                _buildInfoColumn('End', bus['End_Location']),
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
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
