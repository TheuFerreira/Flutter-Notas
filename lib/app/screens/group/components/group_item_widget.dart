import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notas/app/screens/group/components/group_item_bloc.dart';
import 'package:flutter_notas/app/shared/models/group_model.dart';

class GroupItemWidget extends StatefulWidget {
  final GroupModel group;
  final Function(GroupModel)? onTap;
  final Function(GroupModel)? onLongPress;
  final bool? isSelected;
  final bool? isAdd;
  GroupItemWidget(
    this.group, {
    Key? key,
    @required this.onTap,
    this.onLongPress,
    this.isSelected,
    this.isAdd,
  }) : super(key: key);

  @override
  State<GroupItemWidget> createState() => _GroupItemWidgetState();
}

class _GroupItemWidgetState extends State<GroupItemWidget> {
  final _bloc = GroupItemBloc();

  @override
  void initState() {
    super.initState();

    if (widget.isSelected != null) {
      _bloc.setSelection(widget.isSelected!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Visibility(
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: StreamBuilder<bool>(
                        stream: _bloc.isSelected,
                        initialData: false,
                        builder: (context, snapshot) {
                          final isSelected = snapshot.data!;

                          if (isSelected) {
                            return Container(
                              color: Colors.black,
                            );
                          }

                          return DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(15),
                            strokeWidth: 3,
                            dashPattern: [6],
                            child: Container(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                visible: widget.isAdd != true && widget.isSelected != null,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: widget.group.buffer != null
                        ? Image.memory(widget.group.buffer!)
                        : Image.asset(widget.group.icon!),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.group.title!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    if (widget.isSelected != null) {
      onLongPress();
      return;
    }

    widget.onTap!(widget.group);
  }

  void onLongPress() {
    if (widget.isAdd == true) return;

    _bloc.changeSelection();
    widget.onLongPress!(widget.group);
  }
}
