class Note {
  final int? id;
  final String content;
  final DateTime dateTime;

  Note({this.id, required this.content,required this.dateTime});

  // Convertir la note en un format compatible SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'dateTime': dateTime.toIso8601String(), // Convertir DateTime en chaîne
    };
  }

  // Créer une note à partir d'un format compatible SQLite
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],  // Récupérer l'ID
      content: map['content'],  // Récupérer le contenu
      dateTime: DateTime.parse(map['dateTime']),  // Convertir la chaîne en DateTime
    );
  }


}