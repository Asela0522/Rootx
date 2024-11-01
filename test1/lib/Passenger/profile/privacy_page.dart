import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool _isProfilePrivate = true;
  bool _isNotificationsEnabled = true;

  void _toggleProfilePrivacy(bool value) {
    setState(() {
      _isProfilePrivate = value;
    });
    // Provide feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile is now ${_isProfilePrivate ? "private" : "public"}')),
    );
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _isNotificationsEnabled = value;
    });
    // Provide feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications are now ${_isNotificationsEnabled ? "enabled" : "disabled"}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: SwitchListTile(
                secondary: const Icon(Icons.lock), // Use 'secondary' instead of 'leading'
                title: const Text('Make Profile Private'),
                value: _isProfilePrivate,
                onChanged: _toggleProfilePrivacy,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: SwitchListTile(
                secondary: const Icon(Icons.notifications), // Use 'secondary' instead of 'leading'
                title: const Text('Allow Notifications'),
                value: _isNotificationsEnabled,
                onChanged: _toggleNotifications,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
