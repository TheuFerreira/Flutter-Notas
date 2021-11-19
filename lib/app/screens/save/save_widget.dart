import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notas/app/screens/save/components/options_widget.dart';
import 'package:flutter_notas/app/screens/save/components/share_widget.dart';
import 'package:flutter_notas/app/screens/save/components/theme_widget.dart';
import 'package:flutter_notas/app/screens/save/save_bloc.dart';
import 'package:flutter_notas/app/shared/models/note_model.dart';
import 'package:flutter_notas/app/shared/services/dialog_service.dart';

class SaveView extends StatefulWidget {
  final NoteModel note;
  final Function()? onAction;

  SaveView(
    this.note, {
    Key? key,
    this.onAction,
  }) : super(key: key);

  @override
  _SaveViewState createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  final SaveBloc bloc = SaveBloc();
  final DialogService _dialogSerice = DialogService();

  @override
  void initState() {
    bloc.setValues(widget.note);

    super.initState();
  }

  Widget iconButton(IconData icon, {Function()? onPressed, Color? fontColor}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: fontColor != null
            ? fontColor
            : Theme.of(context).textTheme.bodyText1!.color,
      ),
    );
  }

  Widget title(Color? fontColor) {
    return Text(
      widget.note.id != null ? 'Editar Anotação' : 'Nova Anotação',
      style: TextStyle(
        color: fontColor != null
            ? fontColor
            : Theme.of(context).textTheme.bodyText1!.color,
        fontSize: 20.0,
      ),
    );
  }

  Widget appBar(Color? fontColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconButton(
              Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
              fontColor: fontColor,
            ),
            title(fontColor),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              child: iconButton(
                Icons.delete,
                onPressed: () async {
                  var result = await _dialogSerice.showAlertDialog(
                      context,
                      'Confirmação',
                      'Tem certeza de que deseja excluir as notas selecionadas?');

                  if (result == null) {
                    return;
                  }

                  bloc.delete(context, widget.note);
                  widget.onAction!();
                },
                fontColor: fontColor,
              ),
              visible: widget.note.id != null,
            ),
            iconButton(
              Icons.check,
              onPressed: () {
                bloc.save(context, widget.note);
                widget.onAction!();
              },
              fontColor: fontColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget body(Color? fontColor) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: bloc.titleController,
              decoration: InputDecoration(
                hintText: 'Título',
              ),
              style: TextStyle(
                fontSize: 16.0,
                color: fontColor,
              ),
            ),
            TextField(
              controller: bloc.descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              decoration: InputDecoration(
                hintText: 'Descrição',
              ),
              style: TextStyle(
                fontSize: 16.0,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<int>(
          stream: bloc.currentTheme,
          initialData: 0,
          builder: (context, snapshot) {
            final selectedIndex = snapshot.data!;
            final theme = themes[selectedIndex];
            return Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: "Background_${widget.note.id}",
                  child: Container(
                    color: theme.bgColor == null ? Colors.white : theme.bgColor,
                    child: theme.bgAsset != null
                        ? Image.asset(
                            theme.bgAsset!,
                            fit: BoxFit.fitHeight,
                          )
                        : null,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      appBar(theme.fontColor),
                      body(theme.fontColor),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showOptionsWidget,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  void showOptionsWidget() {
    showModalBottomSheet(
      context: context,
      builder: (context) => OptionsWidget(
        showShare: widget.note.id != null,
        themeTap: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => ThemeWidget(bloc),
          );
        },
        shareTap: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => ShareWidget(
              fileTap: () async {
                await bloc.shareFile();
                Navigator.pop(context);
              },
              copyTap: () {
                bloc.copyText();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Descrição da nota copiado com sucesso!!!'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
