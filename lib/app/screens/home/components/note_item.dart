import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/home/components/note_item_block.dart';
import 'package:flutter_notas/app/shared/const/themes.dart';
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
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Visibility(
                child: Hero(
                  tag: 'BackgroundColor_${note.id}',
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: themes[note.theme!].bgColor != null
                        ? themes[note.theme!].bgColor
                        : Colors.white,
                  ),
                ),
                visible: themes[note.theme!].bgColor != null,
              ),
              Visibility(
                child: Hero(
                  tag: 'BackgroundImage_${note.id}',
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: themes[note.theme!].bgAsset != null
                        ? Image.asset(
                            themes[note.theme!].bgAsset!,
                            fit: BoxFit.fitWidth,
                          )
                        : null,
                  ),
                ),
                visible: themes[note.theme!].bgAsset != null,
              ),
              Padding(
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
                        style: TextStyle(
                          fontSize: 14.0,
                          color: themes[note.theme!].lastModifyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String data, BuildContext context) {
    return Text(
      data,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16.0,
        color: themes[note.theme!].fontColor != null
            ? themes[note.theme!].fontColor
            : Theme.of(context).textTheme.bodyText1!.color,
      ),
    );
  }
}
