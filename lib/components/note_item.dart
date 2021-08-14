import 'package:flutter/material.dart';
import 'package:flutter_notas/models/note_model.dart';
import 'package:flutter_notas/views/home/home_controller.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatefulWidget {
  final NoteModel note;
  final void Function()? onTap;

  const NoteItem(
    this.note, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: _isSelected ? Colors.blueAccent : Colors.transparent,
        ),
        constraints: BoxConstraints(maxHeight: 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: InkWell(
            onTap: () {
              if (_isSelected) {
                setState(() => _isSelected = false);
                return;
              }

              widget.onTap!();
            },
            onLongPress: () {
              setState(() => _isSelected = !_isSelected);
            },
            child: Card(
              elevation: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: _isSelected
                            ? MediaQuery.of(context).size.width - 70
                            : double.maxFinite,
                      ),
                      child: Text(
                        widget.note.title != ''
                            ? widget.note.title!
                            : widget.note.description!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  if (_isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          setState(() => _isSelected = false);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
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
}
