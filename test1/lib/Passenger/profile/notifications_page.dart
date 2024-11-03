import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.orange ,
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          NotificationCard(
            title: 'Notification 1',
            subtitle: 'Details of notification 1',
            icon: Icons.notifications,
          ),
          NotificationCard(
            title: 'Notification 2',
            subtitle: 'Details of notification 2',
            icon: Icons.info,
          ),
          NotificationCard(
            title: 'Notification 3',
            subtitle: 'Details of notification 3',
            icon: Icons.warning,
          ),
          // Add more notifications as needed
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        // Add an onTap function if you want to handle tap events
        onTap: () {
          // Handle tap event
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on $title')),
          );
        },
      ),
    );
  }
}
