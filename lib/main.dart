
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground_wheel_nav/Provider/CircleProvider.dart';
import 'package:provider/provider.dart';
import 'CirclePage.dart';

void main()=> runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CircleP>.value(value: CircleP()),
      ],
      child: MaterialApp(
        home: Wheel(),
      ),
    );
  }
}




