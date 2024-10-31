import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/api_bus_search.dart';
import 'package:test1/Passenger/BUS_SEARCH/BusSelectionScreen.dart';
import 'package:test1/Passenger/screens/home.dart';

class SearchBus extends StatelessWidget {
  const SearchBus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Bus',
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
    if (locations != null) {
      setState(() {
        fromLocations = locations;
        isLoadingFromLocations = false;
      });
    } else {
      setState(() {
        isLoadingFromLocations = false;
      });
    }
  }

  Future<void> _fetchToLocations() async {
    var locations = await ApiService.fetchToLocations();
    if (locations != null) {
      setState(() {
        toLocations = locations;
        isLoadingToLocations = false;
      });
    } else {
      setState(() {
        isLoadingToLocations = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
        ),
        title: const Text('Bus Search'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isLoadingFromLocations
                ? const CircularProgressIndicator()
                : buildDropdownField(
                    'From', selectedFromLocation, fromLocations, (value) {
                    setState(() {
                      selectedFromLocation = value;
                    });
                  }),
            const SizedBox(height: 16),
            isLoadingToLocations
                ? const CircularProgressIndicator()
                : buildDropdownField('To', selectedToLocation, toLocations,
                    (value) {
                    setState(() {
                      selectedToLocation = value;
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
                    'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (selectedFromLocation != null &&
                    selectedToLocation != null &&
                    selectedDate != null) {
                  var result = await ApiService.searchBus(
                    from: selectedFromLocation!,
                    to: selectedToLocation!,
                    date: selectedDate!,
                  );
                  if (result != null && result.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BusSelectionScreen(busData: result),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No buses found. Please try again.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select all fields.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Search Bus'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, String? selectedValue,
      List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
