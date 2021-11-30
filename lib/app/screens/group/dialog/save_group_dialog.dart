import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/group/dialog/models/default_group_model.dart';
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
          title: Text(
            'Adicionar Grupo',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Colors.black,
                      selectionColor: Colors.grey[300],
                      selectionHandleColor: Colors.black,
                    ),
                  ),
                  child: TextField(
                    controller: _bloc.titleController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Título*',
                      hintStyle: TextStyle(color: Colors.black54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                StreamBuilder<String>(
                  stream: _bloc.selectedOption,
                  initialData: 'Padrão',
                  builder: (context, snapshot) {
                    final value = snapshot.data!;
                    return DropdownButton(
                      underline: Divider(height: 8),
                      isExpanded: true,
                      value: value,
                      items: ['Padrão', 'Customizado']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: _bloc.changeOptions,
                    );
                  },
                ),
                StreamBuilder(
                  stream: _bloc.selectedOption,
                  initialData: 'Padrão',
                  builder: (context, snapshot) {
                    final value = snapshot.data!;
                    if (value == 'Padrão') {
                      return SizedBox(
                        height: 64,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<int>(
                          stream: _bloc.selectedDefaultGroup,
                          initialData: 0,
                          builder: (context, snapshot) {
                            int selectedIndex = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              children: defaultGroups.map(
                                (e) {
                                  final index = defaultGroups.indexOf(e);
                                  bool isSelected = index == selectedIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      _bloc.changeDefaultGroup(index);
                                    },
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        DottedBorder(
                                          radius: Radius.circular(16.0),
                                          dashPattern: [10, 10, 10, 10],
                                          strokeWidth: 2,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Image.asset(e.imageURL),
                                          ),
                                        ),
                                        Visibility(
                                          child: Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.check,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          visible: isSelected,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      );
                    } else if (value == 'Customizado') {
                      return Row(
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
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Trocar Imagem',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ],
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
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
              child: Text(
                'Adicionar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
