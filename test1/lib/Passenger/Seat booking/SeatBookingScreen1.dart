import 'package:flutter/material.dart';

class BusBookingScreen extends StatefulWidget {
  final Map<String, dynamic> busData;

  const BusBookingScreen({super.key, required this.busData});

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  final List<int> selectedSeats = [];
  late List<int> bookedSeats;
  late int totalSeats;
  static const double seatPrice = 25.0;

  @override
  void initState() {
    super.initState();
    // Initialize bookedSeats and totalSeats from busData
    bookedSeats = List<int>.from(widget.busData['Booked_Seats_Number'] ?? []);
    totalSeats = widget.busData['Total_Seats'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Bus Seats'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  BusSeatLayout(
                    selectedSeats: selectedSeats,
                    bookedSeats: bookedSeats,
                    totalSeats: totalSeats,
                    onSeatSelected: _handleSeatSelection,
                  ),
                  const SizedBox(height: 20),
                  _buildSeatLegend(),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  void _handleBooking() {
    if (selectedSeats.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Booking Confirmed'),
            content: Text('You have booked seats: ${selectedSeats.join(", ")}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      setState(() {
        selectedSeats.clear();
      });
    }
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selected Seats: ${selectedSeats.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total: \$${(selectedSeats.length * seatPrice).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: selectedSeats.isEmpty ? null : _handleBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text(
              'Book Seats',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSeatSelection(int seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }
}

class BusSeatLayout extends StatelessWidget {
  final Function(int) onSeatSelected;
  final List<int> selectedSeats;
  final List<int> bookedSeats;
  final int totalSeats; // New field for total seats

  const BusSeatLayout({
    super.key,
    required this.onSeatSelected,
    required this.selectedSeats,
    required this.bookedSeats,
    required this.totalSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'FRONT',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Create a seat layout based on totalSeats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= totalSeats; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildSeat(i),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'REAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    bool isSelected = selectedSeats.contains(seatNumber);
    bool isBooked = bookedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: isBooked ? null : () => onSeatSelected(seatNumber),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isBooked
              ? Colors.grey
              : isSelected
                  ? Colors.purple
                  : Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            seatNumber.toString(),
            style: TextStyle(
              color: isSelected || isBooked ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Helper widget for seat legend
Widget _buildSeatLegend() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Available', Colors.white),
        _buildLegendItem('Selected', Colors.purple),
        _buildLegendItem('Booked', Colors.grey),
      ],
    ),
  );
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    ],
  );
}
