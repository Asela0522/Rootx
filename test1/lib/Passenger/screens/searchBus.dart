import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/api_bus_search.dart'; // Import the backend API file // Import the backend API file

class SearchBus extends StatelessWidget {
  const SearchBus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Bus',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const BusBookingScreen(),
    );
  }
}

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({super.key});

  @override
  _BusBookingScreenState createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  DateTime? selectedDate;
  List<String> fromLocations = []; // This will hold the dynamic locations from the API
  List<String> toLocations = [];

  String? selectedFromLocation;
  String? selectedToLocation;

  bool isLoadingFromLocations = true;
  bool isLoadingToLocations = true;

  @override
  void initState() {
    super.initState();
    _fetchFromLocations(); // Fetch the "from" locations when the screen loads
    _fetchToLocations(); // Fetch the "to" locations
  }

  Future<void> _fetchFromLocations() async {
    var locations = await ApiService.fetchFromLocations(); // Fetch locations from API
    if (locations != null) {
      setState(() {
        fromLocations = locations;
        isLoadingFromLocations = false;
      });
    } else {
      // Handle error if locations could not be fetched
      setState(() {
        isLoadingFromLocations = false;
      });
    }
  }

  Future<void> _fetchToLocations() async {
    var locations = await ApiService.fetchToLocations(); // Fetch locations from API
    if (locations != null) {
      setState(() {
        toLocations = locations;
        isLoadingToLocations = false;
      });
    } else {
      // Handle error if locations could not be fetched
      setState(() {
        isLoadingToLocations = false;
      });
    }
  }

  // Function to open a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Book Your Seat')),
        backgroundColor: Colors.orange,
        toolbarHeight: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Add your action here, e.g., open a drawer or menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Search Bus', style: TextStyle(fontSize: 16, color: Colors.orange)),
                  Text('Select Bus', style: TextStyle(fontSize: 16, color: Colors.black54)),
                  Text('Payment', style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 16),
              isLoadingFromLocations
                  ? const CircularProgressIndicator()
                  : buildDropdownField('From', selectedFromLocation, fromLocations, (value) {
                setState(() {
                  selectedFromLocation = value;
                });
              }),
              const SizedBox(height: 16),
              isLoadingToLocations
                  ? const CircularProgressIndicator()
                  : buildDropdownField('To', selectedToLocation, toLocations, (value) {
                setState(() {
                  selectedToLocation = value;
                });
              }),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              if (selectedDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0],
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Call the backend API to search for buses
                  if (selectedFromLocation != null && selectedToLocation != null && selectedDate != null) {
                    var result = await ApiService.searchBus(
                      from: selectedFromLocation!,
                      to: selectedToLocation!,
                      date: selectedDate!,
                    );
                    if (result != null) {
                      // Display result or handle accordingly
                      print(result);
                    } else {
                      // Handle error
                      print('Error searching bus');
                    }
                  }
                },
                child: const Text('Search Bus', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
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

  // Helper function to build dropdown fields
  Widget buildDropdownField(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      width: 300,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
