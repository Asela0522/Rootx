import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/bus_api.dart'; // Import your backend connectivity here.

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
      appBar: AppBar(
        title: const Text('Bus Selection'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
                fetchBusData(); // Refresh data
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: _buildLoadingIndicator())
          : ListView.builder(
        itemCount: buses.length,
        itemBuilder: (context, index) {
          return BusCard(bus: buses[index]);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 8, // Shadow for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_bus, color: Colors.orange, size: 30),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bus['Bus_Name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  'Rs. ${bus['Ticket_Price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Seats', '${bus['Total_Seats']}'),
            _buildInfoRow('Route', bus['Route_Number']),
            _buildInfoRow('Start', bus['Start_Location']),
            _buildInfoRow('End', bus['End_Location']),
            _buildInfoRow('Time', bus['Start_Time']),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement booking functionality here
                // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
