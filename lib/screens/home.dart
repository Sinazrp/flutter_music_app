import 'package:flutter/material.dart';
import 'package:flutter_music_app/constant/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Musiclot',
          style:
              TextStyle(fontSize: 18, color: whiteColor, fontFamily: 'Elianto'),
        ),
      ),
    );
  }
}
