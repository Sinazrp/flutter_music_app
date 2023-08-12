import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Varino',
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0)),
    );
  }
}
