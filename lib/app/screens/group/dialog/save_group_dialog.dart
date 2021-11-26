import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/group/dialog/save_group_bloc.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class SaveGroupDialog {
  final _bloc = SaveGroupBloc();
  final Function()? onSave;

  SaveGroupDialog(
    GroupModel group, {
    @required this.onSave,
  }) {
    _bloc.setValues(group);
  }

  void show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Adicionar Grupo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bloc.titleController,
                decoration: InputDecoration(
                  hintText: 'Título*',
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: DottedBorder(
                      radius: Radius.circular(16.0),
                      dashPattern: [10, 10, 10, 10],
                      strokeWidth: 2,
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<Uint8List?>(
                        stream: _bloc.asSelectedImage,
                        initialData: null,
                        builder: (context, snapshot) {
                          Uint8List? buffer = snapshot.data;
                          if (buffer == null) {
                            return Container();
                          }
                          return Image.memory(buffer);
                        },
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _bloc.changeImage,
                    icon: Icon(Icons.image),
                    label: Text('Trocar Imagem'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                await _bloc.save();
                Navigator.of(context).pop();
                onSave!();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
