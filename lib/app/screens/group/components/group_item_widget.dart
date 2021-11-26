import 'package:flutter/material.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class GroupItemWidget extends StatelessWidget {
  final GroupModel group;
  final Function(GroupModel)? onTap;
  const GroupItemWidget(
    this.group, {
    Key? key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(group),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 2,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: group.buffer != null
                  ? Image.memory(group.buffer!)
                  : Image.asset(group.icon!),
            ),
            SizedBox(height: 16.0),
            Text(
              group.title!,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
