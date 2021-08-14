import 'package:flutter/material.dart';
import 'package:flutter_notas/models/note_model.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;
  final void Function()? onTap;

  const NoteItem(
    this.note, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: 100,
        ),
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                note.title != null ? note.title! : note.description!,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
