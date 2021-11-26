import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_notas/app/shared/database/dao/group.dao.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
import 'package:flutter_notas/app/shared/services/image_service.dart';
import 'package:rxdart/rxdart.dart';

class SaveGroupBloc {
  late GroupModel group;
  final titleController = TextEditingController();
  late Uint8List? imageBuffer;
  final _dao = GroupDAO();

  final _streamSelectedImage = BehaviorSubject<Uint8List?>();
  Stream<Uint8List?> get asSelectedImage => _streamSelectedImage.stream;

  void setValues(GroupModel group) {
    this.group = group;
    imageBuffer = group.buffer;
    if (group.idGroup == null) return;

    titleController.text = group.title!;
    _streamSelectedImage.add(imageBuffer);
  }

  void changeImage() async {
    imageBuffer = await ImageService().getImage();
    _streamSelectedImage.add(imageBuffer);
  }

  Future save() async {
    String title = titleController.text.trim();
    if (title.isEmpty || imageBuffer == null) return;

    group.title = title;
    group.buffer = imageBuffer!;
    await _dao.save(group);
  }
}
