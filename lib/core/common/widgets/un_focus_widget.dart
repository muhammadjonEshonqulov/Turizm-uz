import 'package:flutter/material.dart';

class OnUnFocusTap extends StatelessWidget {
  final Widget child;

  const OnUnFocusTap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        for (var action in currentFocus.children) {
          action.unfocus();
        }
      },
      child: child,
    );
  }
}
