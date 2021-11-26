import 'package:flutter/material.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class LayerTileWidget extends StatelessWidget {
  final GroupModel group;
  final bool? isSelected;
  final Function(GroupModel)? onTap;
  const LayerTileWidget(
    this.group, {
    Key? key,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Material(
        shadowColor: Theme.of(context).textTheme.bodyText1!.color,
        elevation: isSelected == true ? 2 : 0,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: group.buffer != null
                  ? Image.memory(group.buffer!)
                  : Image.asset('assets/images/groups/group_add.png'),
            ),
            Text(
              group.title!,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    onTap!(group);
  }
}
