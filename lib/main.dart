import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack19/presentations/proxy_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterable',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: ProxyScreen(),
    );
  }
}
