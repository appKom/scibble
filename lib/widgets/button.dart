import 'package:flutter/material.dart';

import 'package:scibble/theme/scibble_color.dart';

class Button extends StatelessWidget {
  final void Function() onPress;
  final Widget child;
  final ButtonColor color;

  Button({this.onPress, this.child, this.color = ButtonColor.primary});

  Color get _buttonColor {
    switch (color) {
      case ButtonColor.primary:
        return ScibbleColor.onlineBlue;
      case ButtonColor.secondary:
        return ScibbleColor.onlineOrange;
      default:
        return ScibbleColor.onlineBlue;
    }
  }

  Color get _splashColor {
    switch (color) {
      case ButtonColor.primary:
        return ScibbleColor.onlineOrange;
      case ButtonColor.secondary:
        return ScibbleColor.onlineBlue;
      default:
        return ScibbleColor.onlineOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FlatButton(
        color: _buttonColor,
        textColor: Colors.white,
        splashColor: _splashColor,
        disabledColor: ScibbleColor.onlineBlueDisabled,
        padding: EdgeInsets.all(5.0),
        onPressed: onPress,
        child: child,
      ),
    );
  }
}

enum ButtonColor {
  primary,
  secondary,
}
