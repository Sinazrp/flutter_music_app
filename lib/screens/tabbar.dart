// ignore_for_file: must_be_immutable

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/screens/home.dart';
import 'package:flutter_music_app/screens/player.dart';

class Tabbarr extends StatelessWidget {
  Tabbarr({Key? key}) : super(key: key);
  var pageList = [Home(), Player()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.deepPurple.shade800.withOpacity(0.9),
        Colors.deepPurple.shade200.withOpacity(0.7)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: FluidNavBar(
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.deepPurple.shade200,
              iconSelectedForegroundColor: Colors.white),
          // (1)
          icons: [
            // (2)
            FluidNavBarIcon(
                icon: Icons.play_arrow_rounded,
                unselectedForegroundColor: Colors.white),
            FluidNavBarIcon(
                icon: Icons.list_rounded,
                unselectedForegroundColor: Colors.white), // (3)
          ],

          // (4)
        ),
        body: pageList[1],
      ),
    );
  }
}
