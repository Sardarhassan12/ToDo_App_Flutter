import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoApp.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: TodoApp(),
    );
  }
}
