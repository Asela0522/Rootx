import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/api_bus_search.dart';
import 'package:test1/Passenger/BUS_SEARCH/BusSelectionScreen.dart';

class SearchBus extends StatelessWidget {
  const SearchBus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Bus',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
  List<String> fromLocations = [];
  List<String> toLocations = [];
  String? selectedFromLocation;
  String? selectedToLocation;
  bool isLoadingFromLocations = true;
  bool isLoadingToLocations = true;

  @override
  void initState() {
    super.initState();
    _fetchFromLocations();
    _fetchToLocations();
  }

  Future<void> _fetchFromLocations() async {
    var locations = await ApiService.fetchFromLocations();
    setState(() {
      fromLocations = locations ?? [];
      isLoadingFromLocations = false;
    });
  }

  Future<void> _fetchToLocations() async {
    var locations = await ApiService.fetchToLocations();
    setState(() {
      toLocations = locations ?? [];
      isLoadingToLocations = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showLocationDialog(List<String> locations, Function(String) onLocationSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Location', style: TextStyle(fontSize: 20)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locations[index]),
                  onTap: () {
                    onLocationSelected(locations[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Bus Search'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildLocationSelector('From', selectedFromLocation, fromLocations, (selectedLocation) {
                setState(() {
                  selectedFromLocation = selectedLocation;
                });
              }),
              const SizedBox(height: 16),
              _buildLocationSelector('To', selectedToLocation, toLocations, (selectedLocation) {
                setState(() {
                  selectedToLocation = selectedLocation;
                });
              }),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Select Date', style: TextStyle(fontSize: 18)),
              ),
              if (selectedDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (selectedFromLocation != null && selectedToLocation != null && selectedDate != null) {
                    var result = await ApiService.searchBus(
                      from: selectedFromLocation!,
                      to: selectedToLocation!,
                      date: selectedDate!,
                    );
                    if (result != null && result.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusSelectionScreen(busData: result),
                        ),
                      );
                    } else {
                      _showAlertDialog(context, 'No buses found. Please try again.');
                    }
                  } else {
                    _showAlertDialog(context, 'Please select all fields.');
                  }
                },
                child: const Text('Search Bus', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSelector(String label, String? selectedValue, List<String> locations, Function(String) onLocationSelected) {
    return GestureDetector(
      onTap: () {
        if (label == 'From' && !isLoadingFromLocations) {
          _showLocationDialog(locations, onLocationSelected);
        } else if (label == 'To' && !isLoadingToLocations) {
          _showLocationDialog(locations, onLocationSelected);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? 'Select $label',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.orange),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
