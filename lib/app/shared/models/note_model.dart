import 'package:flutter_notas/app/shared/models/group_model.dart';

class NoteModel {
  int? id;
  GroupModel? group;
  String? title;
  String? description;
  DateTime? lastModify;
  int? theme;

  NoteModel();

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id_note'];
    title = json['title'];
    description = json['description'];
    lastModify = DateTime.fromMillisecondsSinceEpoch(json['last_modify']);
    theme = json['theme'];
    group = null;

    if (json['id_group'] != null && json['g_title'] != null) {
      group = GroupModel();
      group!.idGroup = json['id_group'];
      group!.title = json['g_title'];
      group!.buffer = json['image'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id_note': id,
      'id_group': group == null ? null : group!.idGroup!,
      'title': title,
      'description': description,
      'last_modify': lastModify!.millisecondsSinceEpoch,
      'theme': theme,
    };
  }
}
