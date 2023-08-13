import 'package:flutter/material.dart';
import 'package:flutter_music_app/screens/home.dart';
import 'package:flutter_music_app/screens/player.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music App',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Elianto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          )),
      home: Home(),
    );
  }
}
