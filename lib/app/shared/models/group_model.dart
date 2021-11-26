import 'dart:typed_data';

class GroupModel {
  int? idGroup;
  String? title;
  String? icon;
  Uint8List? buffer;

  GroupModel();

  GroupModel.fromJson(Map<String, dynamic> json)
      : idGroup = json['id_group'],
        title = json['title'],
        buffer = json['image'];

  Map<String, dynamic> toJson() {
    return {
      'id_group': idGroup,
      'title': title,
      'image': buffer,
    };
  }

  GroupModel.fromAdd()
      : title = 'Adicionar Grupo',
        icon = 'assets/images/groups/group_add.png';
}
