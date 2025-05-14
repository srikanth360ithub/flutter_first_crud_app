import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  const NoteDetailScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(title, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Description:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
