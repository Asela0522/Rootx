import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusTicketScanner extends StatefulWidget {
  const BusTicketScanner({super.key});

  @override
  State<StatefulWidget> createState() => _BusTicketScannerState();
}

class _BusTicketScannerState extends State<BusTicketScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isProcessing = false;
  String? paymentStatus;
  Map<String, dynamic>? ticketData;

  @override
  void reassemble() {
    super.reassemble();
    if (defaultTargetPlatform == TargetPlatform.android) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  Future<void> _launchPayment(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch payment URL');
    }
  }

  Future<void> _verifyPayment(String sessionId) async {
    try {
      final response = await http.get(
        Uri.parse('http://your-backend-url:5000/verify_payment/$sessionId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          paymentStatus = data['payment_status'];
        });
      }
    } catch (e) {
      print('Error verifying payment: $e');
    }
  }

  Widget _buildTicketInfo() {
    if (ticketData == null) return const SizedBox();

    final info = ticketData!['ticket_info'];
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus Ticket Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text('Bus Name: ${info['bus_name']}'),
            Text('Bus Number: ${info['bus_number']}'),
            Text('Route: ${info['route']}'),
            Text('Route Number: ${info['route_number']}'),
            Text('Price: \$${info['price']}'),
            Text('Travel Date: ${info['travel_date']}'),
            Text('Start Time: ${info['start_time']}'),
            Text('Seat Number: ${info['seat_number']}'),
            Text('Generated: ${info['generated_at']}'),
            const SizedBox(height: 16),
            if (paymentStatus == null || paymentStatus == 'unpaid')
              ElevatedButton(
                onPressed: () {
                  _launchPayment(ticketData!['payment_url']);
                },
                child: const Text('Pay Now'),
              )
            else if (paymentStatus == 'paid')
              const Chip(
                label: Text('Payment Completed'),
                backgroundColor: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Ticket Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () async {
              await controller?.toggleFlash();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: _buildTicketInfo(),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!isProcessing && scanData.code != null) {
        setState(() {
          isProcessing = true;
        });

        try {
          final decodedData = json.decode(scanData.code!);
          if (decodedData['type'] == 'bus_ticket') {
            setState(() {
              ticketData = decodedData;
            });

            // Start checking payment status
            if (decodedData['session_id'] != null) {
              await _verifyPayment(decodedData['session_id']);
            }
          }
        } catch (e) {
          print('Error processing QR code: $e');
        }

        // Add delay before next scan
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isProcessing = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}