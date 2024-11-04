import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the ListView
        child: ListView(
          children: const [
            PaymentMethodCard(
              title: 'Credit Card',
              subtitle: '**** **** **** 1234',
              icon: Icons.credit_card,
            ),
            SizedBox(height: 16), // Space between cards
            PaymentMethodCard(
              title: 'PayPal',
              subtitle: 'your-email@example.com',
              icon: Icons.paypal,
            ),
            // Add more payment methods as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add payment method action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow for the card
      child: ListTile(
        leading: Icon(icon, size: 40), // Add icon for the payment method
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Handle edit action
          },
        ),
      ),
    );
  }
}
