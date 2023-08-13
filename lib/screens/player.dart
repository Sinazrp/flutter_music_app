import 'package:flutter/material.dart';
import 'package:flutter_music_app/constant/colors.dart';
import 'package:flutter_music_app/controller/player_controller.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/background_filter.dart';

class Player extends StatelessWidget {
  Player({
    Key? key,
  }) : super(key: key);

  var controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    int index = controller.playIndex.value;
    SongModel songModel = controller.musicList[index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(fit: StackFit.expand, children: [
        QueryArtworkWidget(
          artworkBorder: BorderRadius.circular(0),
          id: songModel.id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: Image.asset(
              'assets/fonts/images/HD-wallpaper-liquifying-thoughts-listening-music-girl-color-mysterious-abstract.jpg',
              fit: BoxFit.cover),
        ),
        const BackGroundFilter(),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  songModel.title,
                  style: const TextStyle(
                      color: whiteColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  songModel.artist.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 213, 211, 211),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*  const Text(
                '0:0',
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 211, 211),
                  fontSize: 13,
                ),
              ), */
              Expanded(
                child: Slider(
                  value: 0.0,
                  thumbColor: Colors.deepPurple.shade200,
                  activeColor: const Color.fromARGB(105, 255, 255, 255),
                  onChanged: (newValue) {},
                ),
              ),

              /*   const Text(
                '04:00',
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 211, 211),
                  fontSize: 13,
                ),
              ), */
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: whiteColor,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: controller.isPlaying.value
                      ? const Icon(
                          Icons.pause_rounded,
                          color: whiteColor,
                          size: 45,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          color: whiteColor,
                          size: 45,
                        )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: whiteColor,
                    size: 35,
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ])
      ]),
    );
  }
}
