import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onDeletePressed;

  const NoteWidget({
    super.key,
    required this.note,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Title: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(note.title),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Content: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(note.content),
              ],
            ),
            IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
