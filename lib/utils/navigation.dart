import 'package:flutter/material.dart';

/// Generic function to navigate with custom page transition animation.
void navigateWithAnimation(
  BuildContext context,
  Widget destinationPage, {
  TransitionType transitionType = TransitionType.slide,
  Duration duration = const Duration(milliseconds: 200),
}) {
  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.rotation:
            return RotationTransition(turns: animation, child: child);
          case TransitionType.slide:
          default:
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
        }
      },
      transitionDuration: duration,
    );
  }

  Navigator.push(context, _createRoute());
}

/// Enum to specify different types of transitions.
enum TransitionType {
  slide,
  fade,
  scale,
  rotation,
}
