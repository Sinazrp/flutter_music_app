import 'package:flutter/material.dart';
import 'package:flutter_music_app/constant/colors.dart';
import 'package:flutter_music_app/constant/text_style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Musiclot', style: appBarStyle()),
      ),
    );
  }
}
