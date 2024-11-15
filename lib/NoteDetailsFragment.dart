import 'Note.dart';
import 'package:flutter/material.dart';

class NoteDetailsFragment extends StatelessWidget {
  final Note note;

  const NoteDetailsFragment({required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contenu: ${note.content}'),
        Text('Date/Heure: ${note.dateTime.toString()}'),
      ],
    );
  }


}
