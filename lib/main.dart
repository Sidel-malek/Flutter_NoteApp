import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'Note.dart';
import 'DatabaseHelper.dart';

import 'NoteDetailsScreen.dart';
import 'splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),// Commence par le Splash Screen
      routes:{
        '/note': (context) => HomePage(),
      },
    );

  }
}


// home Page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State
{

  Note? _selectedNote;
  final FlutterTts _flutterTts = FlutterTts();

  bool _isSpeaking = false;

  List  <Note> _notes = []; // Liste des notes
  final DatabaseHelper _databaseHelper = DatabaseHelper();// Instance de DatabaseHelper


  @override
  void initState() {
    super.initState();
    _loadNotes();

  }

  void _loadNotes() async {
    final notes = await _databaseHelper.getNotes();  // Récupérer les notes de la base de données
    setState(() {
      _notes = notes;  // Mettre à jour la liste des notes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Note'),
      ),
      body: Row(
        children: [
          Expanded(
            child: _buildNotesList(), // Liste recyclée de notes
          ),
          if (MediaQuery.of(context).orientation == Orientation.landscape && _selectedNote != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contenu: ${_selectedNote!.content}'),
                  Text('Date/Heure: ${_selectedNote!.dateTime.toString()}'),
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
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote, // Ajoute une note depuis le bouton flottant
        child: Icon(Icons.add),
      ),
    );
  }

  // Méthode pour construire la liste des notes
  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {

        return ListTile(
          subtitle: Text(_notes[index].content),
          onLongPress: () => _showDeleteConfirmationDialog(index),
          onTap: () => _showNoteDetails(_notes[index]),
        );
      },
    );
  }
  void _toggleSpeech() {
    setState(() {
      _isSpeaking = !_isSpeaking; // Inverse l'état de la lecture audio
    });

    if (_isSpeaking) {
      _speakNote(); // Démarre la lecture audio
    } else {
      _stopSpeaking(); // Arrête la lecture audio
    }
  }
  Future<void> _speakNote() async {
    String content = _selectedNote!.content;
    await _flutterTts.setLanguage("fr-FR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(content);

  }


  // Méthode pour arrêter la lecture audio
  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
  }
  void _showNoteDetails(Note note) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // Si en mode portrait, lance une nouvelle activité pour afficher les détails
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteDetailsScreen(
            note: note,

          ),
        ),

      );
    } else {
      // Si en mode paysage, affiche les détails dans une colonne à côté de la liste des notes
      setState(() {
        _selectedNote = note; // Met à jour la note sélectionnée
      });
    }
  }


  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression ?'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette note ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _databaseHelper.deleteNoteById(_notes[index].id!);  // Supprimer la note par ID
                _loadNotes();
                // Supprime l'élément de la liste
                setState(() {
                  _notes.removeAt(index);
                });
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour ajouter une note
  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = ''; // Titre de la note
        String content = ''; // Contenu de la note


        return AlertDialog(
          title: Text('Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    content = value; // Met à jour le contenu de la note
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Crée une nouvelle note
                final newNote = Note(
                  content: content,
                  dateTime: DateTime.now(), // Date actuelle
                );
                setState(() {

                  _notes.add(newNote);
                });

                _databaseHelper.addNote(newNote);
                _loadNotes();  // Recharger les notes
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('ajouter'),
            ),
          ],
        );
      },
    );
  }




  @override
  void dispose() {

    _stopSpeaking(); // Stop text-to-speech before destroying the widget
    super.dispose();
  }

}

