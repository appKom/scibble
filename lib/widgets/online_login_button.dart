import 'package:flutter/widgets.dart';

import 'package:scibble/widgets/button.dart';

class LoginButton extends StatelessWidget {
  final String code;
  final void Function() goToLoginView;
  LoginButton({Key key, this.code, this.goToLoginView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      onPress: code == null ? goToLoginView : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Online_hvit_o.png',
            height: 30,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Logg inn gjennom Online',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
