import 'package:flutter/material.dart';
import 'package:recetarium/Pages/categorylist.dart';
import 'Pages/mainMenu.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetarium',
      initialRoute: "/",
      routes: {
        '/': (context) => MainMenu(),
        '/category':(context)=>CategoryList(),
        
        // 'info':(context)=>InfoCosecheros()
      },
    );
  }
}