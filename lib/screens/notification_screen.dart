import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static list of notifications
    final List<Map<String, String>> notifications = [
      {
        'title': 'New Task Assigned',
        'subtitle': 'You have a new task: Design Landing Page.',
        'time': '10 mins ago'
      },
      {
        'title': 'Project Deadline',
        'subtitle': 'Reminder: Project Alpha is due tomorrow.',
        'time': '1 hour ago'
      },
      {
        'title': 'Meeting Reminder',
        'subtitle': 'Team meeting at 3:00 PM today.',
        'time': '2 hours ago'
      },
      {
        'title': 'System Update',
        'subtitle': 'A new version of the app is available.',
        'time': 'Yesterday'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.teal),
              title: Text(notification['title'] ?? ''),
              subtitle: Text(notification['subtitle'] ?? ''),
              trailing: Text(
                notification['time'] ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
