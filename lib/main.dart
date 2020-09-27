import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:scibble/Page/login.dart';

void main() async {
  // Necessary to wait for config retrieval
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(Scibble());
}

class Scibble extends StatefulWidget {
  @override
  _ScibbleState createState() => _ScibbleState();
}

class _ScibbleState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scibble',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Scibble'),
      home: Login(),
    );
  }
}
