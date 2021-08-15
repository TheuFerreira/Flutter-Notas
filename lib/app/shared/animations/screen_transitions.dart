import 'package:flutter/cupertino.dart';

class ScreenTransition {
  PageRouteBuilder rightToLeft(BuildContext context, Widget screen) {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;

        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secAnimation) => screen,
    );
  }
}
