import 'package:flutter/material.dart';

class CustomFloatingButtonWidget extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  const CustomFloatingButtonWidget({
    Key? key,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 60,
          height: 60,
          color: Theme.of(context).iconTheme.color,
          child: Icon(
            icon,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
