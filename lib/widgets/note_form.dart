import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteForm extends StatefulWidget {
  final Note? note;
  final void Function(String, String) onSubmit;

  const NoteForm({super.key, this.note, required this.onSubmit});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;
    }
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty) {
      return;
    }
    widget.onSubmit(_titleController.text.trim(), _descController.text.trim());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              child: Text(widget.note == null ? 'Add Note' : 'Update Note'),
            )
          ],
        ),
      ),
    );
  }
}
