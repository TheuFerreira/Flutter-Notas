class NoteModel {
  int? id;
  String? title;
  String? description;
  DateTime? lastModify;

  NoteModel();

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id_note'],
        title = json['title'],
        description = json['description'],
        lastModify = DateTime.fromMillisecondsSinceEpoch(json['last_modify']);

  Map<String, dynamic> toJson() {
    return {
      'id_note': id,
      'title': title,
      'description': description,
      'last_modify': lastModify!.millisecondsSinceEpoch
    };
  }
}
