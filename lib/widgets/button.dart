import 'package:flutter/material.dart';

import 'package:scibble/theme/scibble_color.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final ButtonColor color;

  Button({this.onPressed, this.child, this.color = ButtonColor.primary});

  Color get _buttonColor => color == ButtonColor.primary
      ? ScibbleColor.onlineBlue
      : ScibbleColor.onlineOrange;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: this._buttonColor,
        padding: EdgeInsets.all(15.0),
      ),
      onPressed: onPressed,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: Colors.white),
        child: child != null ? child! : Container(),
      ),
    );
  }
}

enum ButtonColor {
  primary,
  secondary,
}
