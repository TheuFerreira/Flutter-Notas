import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notas/app/screens/save/components/custom_floating_button_widget.dart';
import 'package:flutter_notas/app/screens/save/components/layer_tile_widget.dart';
import 'package:flutter_notas/app/screens/save/components/options_widget.dart';
import 'package:flutter_notas/app/screens/save/components/share_widget.dart';
import 'package:flutter_notas/app/screens/save/components/theme_widget.dart';
import 'package:flutter_notas/app/screens/save/save_bloc.dart';
import 'package:flutter_notas/app/shared/const/themes.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';
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
              Icons.close,
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
                      'Tem certeza de que deseja excluir a nota selecionada?');

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

  Widget body(Color? fontColor, Color? hintColor) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: bloc.titleController,
              decoration: InputDecoration(
                hintText: 'Título',
                hintStyle: TextStyle(
                  color: hintColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: hintColor == null
                        ? Theme.of(context).textTheme.bodyText1!.color!
                        : hintColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: fontColor == null
                        ? Theme.of(context).textTheme.bodyText1!.color!
                        : fontColor,
                  ),
                ),
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
                hintStyle: TextStyle(
                  color: hintColor,
                ),
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
      resizeToAvoidBottomInset: false,
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
                Visibility(
                  child: Hero(
                    tag: 'BackgroundColor_${widget.note.id}',
                    child: Container(
                      color:
                          theme.bgColor == null ? Colors.white : theme.bgColor,
                    ),
                  ),
                  visible: theme.bgColor != null,
                ),
                Visibility(
                  child: Hero(
                    tag: 'BackgroundImage_${widget.note.id}',
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: theme.bgAsset != null
                          ? Image.asset(
                              theme.bgAsset!,
                              fit: BoxFit.fitHeight,
                            )
                          : null,
                    ),
                  ),
                  visible: theme.bgAsset != null,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      appBar(theme.fontColor),
                      body(theme.fontColor, theme.hintColor),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomFloatingButtonWidget(
                          icon: Icons.layers,
                          onTap: showOptionsLayers,
                        ),
                        SizedBox(height: 8.0),
                        CustomFloatingButtonWidget(
                          icon: Icons.edit,
                          onTap: showOptionsWidget,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showOptionsLayers() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'Selecione um Grupo',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StreamBuilder<List<GroupModel>>(
                  stream: bloc.groups,
                  initialData: [],
                  builder: (context, snapshot) {
                    final groups = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        return StreamBuilder<GroupModel?>(
                          stream: bloc.currentGroup,
                          initialData: null,
                          builder: (context, snapshot) {
                            final currentGroup = snapshot.data;
                            return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16.0,
                                crossAxisSpacing: 16.0,
                                childAspectRatio: .9,
                              ),
                              itemCount: groups.length,
                              itemBuilder: (context, i) {
                                GroupModel group = groups[i];
                                bool isSelected = false;
                                if (currentGroup == null && i == 0) {
                                  isSelected = true;
                                } else if (currentGroup != null) {
                                  if (groups[i].idGroup ==
                                      currentGroup.idGroup) {
                                    isSelected = true;
                                  }
                                }
                                return LayerTileWidget(
                                  group,
                                  isSelected: isSelected,
                                  onTap: bloc.changeSelectedGroup,
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
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
