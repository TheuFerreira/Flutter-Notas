import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/group/components/group_item_widget.dart';
import 'package:flutter_notas/app/screens/group/dialog/save_group_dialog.dart';
import 'package:flutter_notas/app/screens/group/group_bloc.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  final _bloc = GroupBloc();
  final addGroup = GroupModel.fromAdd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          'Grupos',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              width: 200,
              height: 120 + 8,
              child: GroupItemWidget(
                addGroup,
                onTap: (_) =>
                    SaveGroupDialog(GroupModel(), onSave: _bloc.getAll)
                        .show(context),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<GroupModel>>(
                stream: _bloc.asGroups,
                initialData: [],
                builder: (context, snapshot) {
                  final groups = snapshot.data;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: groups!.length,
                    itemBuilder: (context, i) => GroupItemWidget(
                      groups[i],
                      onTap: (group) =>
                          SaveGroupDialog(group, onSave: _bloc.getAll)
                              .show(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
