import 'package:flutter/cupertino.dart';

class ScreenTransition {
  PageRouteBuilder rightToLeft(BuildContext context, Widget screen) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secAnimation) => screen,
    );
  }
}
