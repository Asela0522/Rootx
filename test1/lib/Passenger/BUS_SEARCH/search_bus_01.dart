import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/api_bus_search.dart';
import 'package:test1/Passenger/screens/home.dart'; // Import the backend API file

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
      firstDate: DateTime.now(), // Block previous dates
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add back button icon
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
        ),
        title: const Text('Bus Search'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action here
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
                      // Navigate to the BusSelectionScreen with search results
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusSelectionScreen(
                            fromLocation: selectedFromLocation!,
                            toLocation: selectedToLocation!,
                            travelDate: selectedDate!,
                          ),
                        ),
                      );
                    } else {
                      // Handle error (e.g., no buses found or API error)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No buses found. Please try again.')),
                      );
                    }
                  } else {
                    // Show an error message if any field is not selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select all fields.')),
                    );
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
    );
  }

  // Helper function to build dropdown fields
  Widget buildDropdownField(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return SizedBox(
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

class BusSelectionScreen extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final DateTime travelDate;

  const BusSelectionScreen({
    Key? key,
    required this.fromLocation,
    required this.toLocation,
    required this.travelDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Selection'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('From: $fromLocation'),
            Text('To: $toLocation'),
            Text('Date: ${travelDate.toLocal()}'.split(' ')[0]),
            // Display bus options or any other data you want here
          ],
        ),
      ),
    );
  }
}
