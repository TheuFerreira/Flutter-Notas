import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/home/components/note_item_block.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  final NoteModel note;
  late NoteItemBloc bloc;
  final Function()? onTap;

  NoteItem(
    this.note, {
    Key? key,
    @required this.onTap,
  }) : super(key: key) {
    bloc = NoteItemBloc(note.lastModify!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          selectedTileColor: Theme.of(context).colorScheme.secondary,
          onTap: onTap,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              note.title != '' ? note.title! : note.description!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          subtitle: Text('Última Alteração: ${bloc.lastModify}'),
        ),
      ),
    );
  }
}
