import 'package:flutter/material.dart';
import 'package:musicapp/neumorphic_design_example.dart';
import 'musicplayersample.dart';

void main() => runApp(ClientApp());

class ClientApp extends StatefulWidget {
  @override
  _ClientAppState createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF Pro Display', cardColor: Color(0xFF1F1E24), primaryColor: Color(0xFF1F1E24), backgroundColor: Color(0xFF1F1E24)),
      title: 'Menu Card App',
//      home: NeumorphicApp(),
    home: AudioApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
