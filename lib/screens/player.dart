import 'package:flutter/material.dart';

import '../widgets/background_filter.dart';

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset('assets/fonts/images/dragon.jpg', fit: BoxFit.cover),
        const BackGroundFilter()
      ]),
    );
  }
}
