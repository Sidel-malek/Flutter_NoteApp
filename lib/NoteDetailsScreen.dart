import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'Note.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Note note;

  const NoteDetailsScreen({required this.note});

  @override

  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {

  // ... other code ...
  final _flutterTts = FlutterTts(); // Create a FlutterTts instance

  bool _isSpeaking = false; // Flag to track speech state

  @override
  void initState() {
    super.initState();
    _initializeTts(); // Initialize text-to-speech engine
  }

  @override
  void dispose() {
    _stopSpeaking(); // Stop text-to-speech before destroying the widget
    // Save notes (implementation missing, assuming it's not in this screen)
    super.dispose();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("fr-FR"); // Set language (French in this case)
    await _flutterTts.setSpeechRate(0.5); // Adjust speech rate (optional)
    await _flutterTts.setPitch(1.0); // Adjust pitch (optional)

  }

  Future<void> _speakNote() async {
    if (!_isSpeaking) {
      setState(() {
        _isSpeaking = true;
      });
      await _flutterTts.speak(widget.note.content); // Speak the note content
    }
  }

  Future<void> _stopSpeaking() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la note'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrer les éléments verticalement
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contenu: ${widget.note.content}'),
          Text('Date/Heure: ${widget.note.dateTime.toString()}'),
          IconButton(
            icon: Image.asset(
              'assets/images/sound.jpeg',
              width: 300.0,
              height: 70.0,
            ),
            onPressed: _isSpeaking ? _stopSpeaking : _speakNote,
          ),
        ],
      ),
    );
  }

}
