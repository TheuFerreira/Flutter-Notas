class NoteModel {
  int? id;
  String? title;
  String? description;

  NoteModel();

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id_note'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'id_note': id,
      'title': title,
      'description': description,
    };
  }
}
