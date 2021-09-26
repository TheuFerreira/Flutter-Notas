import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/screens/home/components/note_item_block.dart';
import 'package:flutter_notas/app/screens/home/home_bloc.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  final NoteModel note;
  late NoteItemBloc bloc;
  final Function()? onTap;
  final Function(NoteModel note)? onLongPress;

  NoteItem(
    this.note, {
    Key? key,
    @required this.onTap,
    @required this.onLongPress,
  }) : super(key: key) {
    bloc = NoteItemBloc(note.lastModify!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        elevation: 2,
        child: StreamBuilder<bool>(
          stream: bloc.isSelected,
          initialData: false,
          builder: (context, snapshot) {
            bool isSelected = snapshot.data as bool;

            return ListTile(
              selectedTileColor: Theme.of(context).colorScheme.secondary,
              onTap: () {
                bool isSelecting = AppModule.to.bloc<HomeBloc>().isSeleting;

                if (isSelecting) {
                  bloc.changeSelection();
                  onLongPress!(note);
                  return;
                }

                onTap!();
              },
              selected: isSelected,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  note.title != '' ? note.title! : note.description!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected
                        ? Colors.black
                        : Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              subtitle: Text('Última Alteração: ${bloc.lastModify}'),
              onLongPress: () {
                bloc.changeSelection();
                onLongPress!(note);
              },
              trailing: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
