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
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Hero(
          tag: "Background_${note.id}",
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    child: _text(note.title!, context),
                    visible: note.title != '',
                  ),
                  Visibility(
                    child: _text(note.description!, context),
                    visible: note.title == '',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Última Alteração: ${bloc.lastModify}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _text(String data, BuildContext context) {
    return Text(
      data,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
    );
  }
}
