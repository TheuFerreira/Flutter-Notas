import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ThemeTileWidget extends StatelessWidget {
  final String? title;
  final Color? bgColor;
  final Color? fontColor;
  final String? bgAsset;
  final int? currentIndex;
  final bool? isSelected;
  final Function(int?)? onTap;
  const ThemeTileWidget({
    Key? key,
    @required this.title,
    @required this.fontColor,
    this.bgColor,
    this.bgAsset,
    this.currentIndex,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double minWidth = 100;
    final double minHeight = 140;

    final double scale = 0.15;

    final double maxWidth = minWidth * scale + minWidth;
    final double maxHeight = minHeight * scale + minHeight;

    final duration = Duration(milliseconds: 200);
    final curve = Curves.bounceInOut;

    bool selected = isSelected!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap!(currentIndex);
        },
        child: AnimatedContainer(
          duration: duration,
          width: selected ? maxWidth : minWidth,
          height: selected ? maxHeight : minHeight,
          curve: curve,
          child: Container(
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: duration,
                  width: selected ? maxWidth : minWidth,
                  height: selected ? maxHeight : minHeight,
                  curve: curve,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor == null ? Colors.white : bgColor,
                      borderRadius: BorderRadius.circular(16.0),
                      border: fontColor != null
                          ? null
                          : Border.all(color: Colors.black, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: bgAsset == null
                        ? null
                        : Image.asset(
                            bgAsset!,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  height: 40,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Marquee(
                      text: title!,
                      blankSpace: 40,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: fontColor == null ? Colors.black : fontColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
