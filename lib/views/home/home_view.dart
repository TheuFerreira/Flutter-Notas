import 'package:flutter/material.dart';
import 'package:flutter_notas/components/note_item.dart';
import 'package:flutter_notas/models/note_model.dart';
import 'package:flutter_notas/views/home/home_controller.dart';
import 'package:flutter_notas/views/save_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Provider.of<HomeController>(context, listen: false).findAll();
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        actions: <IconButton>[
          controller.isSelecting
              ? IconButton(
                  onPressed: () {
                    controller.deleteSelecteds();
                  },
                  icon: Icon(Icons.delete),
                )
              : IconButton(
                  onPressed: () => itemTap(NoteModel()),
                  icon: Icon(Icons.add),
                ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (context, index) {
          NoteModel currentNote = controller.notes[index];

          return NoteItem(
            currentNote,
            key: UniqueKey(),
            onTap: () => itemTap(currentNote),
          );
        },
      ),
    );
  }

  void itemTap(NoteModel note) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveView(note),
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {});
  }
}

/*
Consumer<HomeController>(
        builder: (context, controller, _) {
          return FutureBuilder<List<NoteModel>>(
            future: controller.findAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.bookmark,
                          size: 64.0,
                        ),
                        Text(
                          'Nenhuma nota encontrada',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                List<NoteModel> notes = snapshot.data as List<NoteModel>;

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    NoteModel currentNote = notes[index];

                    return NoteItem(
                      currentNote,
                      onTap: () => itemTap(currentNote),
                    );
                  },
                );
              }
            },
          );
        },
      )
      */