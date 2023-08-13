// ignore_for_file: must_be_immutable

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(fit: StackFit.expand, children: [
        Obx(
          () => QueryArtworkWidget(
            artworkBorder: BorderRadius.circular(0),
            id: controller.musicList[controller.playIndex.value].id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Image.asset(
                'assets/fonts/images/HD-wallpaper-liquifying-thoughts-listening-music-girl-color-mysterious-abstract.jpg',
                fit: BoxFit.cover),
          ),
        ),
        const BackGroundFilter(),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Obx(
                    () => Text(
                      controller.musicList[controller.playIndex.value].title,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Obx(
                    () => Text(
                      controller.musicList[controller.playIndex.value].artist
                          .toString(),
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        color: Color.fromARGB(255, 213, 211, 211),
                        fontSize: 13,
                      ),
                    ),
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
                child: Obx(
                  () => Slider(
                    value: controller.positionValue.value,
                    max: controller.durationValue.value,
                    thumbColor: Colors.deepPurple.shade200,
                    min: Duration(seconds: 0).inSeconds.toDouble(),
                    activeColor: const Color.fromARGB(105, 255, 255, 255),
                    onChanged: (newValue) {
                      controller.seekSlider(newValue.toInt());
                      newValue = newValue;
                    },
                  ),
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
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.position.value,
                      style: TextStyle(color: whiteColor, fontFamily: "Roboto"),
                    ),
                    Text(controller.duration.value,
                        style:
                            TextStyle(color: whiteColor, fontFamily: "Roboto"))
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    controller.playSong(controller.playIndex.value - 1);
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: whiteColor,
                    size: 35,
                  )),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isPlaying.value) {
                        controller.pauseSong();
                      } else {
                        controller.resumeSong();
                      }
                    },
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
              ),
              IconButton(
                  onPressed: () {
                    controller.playSong(controller.playIndex.value + 1);
                  },
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
