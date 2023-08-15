// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_music_app/constant/colors.dart';
import 'package:flutter_music_app/constant/text_style.dart';
import 'package:flutter_music_app/controller/player_controller.dart';
import 'package:flutter_music_app/screens/player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var controller = Get.put(PlayerController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.deepPurple.shade800.withOpacity(0.9),
        Colors.deepPurple.shade200.withOpacity(0.7)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 75, top: 12),
                      child: Text(
                        '${controller.musicList[controller.playIndex.value].title}sdadasada',
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Obx(
                      () => InkWell(
                        child: CircleAvatar(
                          radius: 30,
                          child: controller.isPlaying.value
                              ? const SpinKitRipple(
                                  color: Color.fromARGB(255, 213, 99, 64),
                                  size: 50.0,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                ),
                        ),
                        onTap: () => Get.to(() => Player()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Musiclot', style: appBarStyle()),
            leading: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
              ),
            ),
            actions: const [
              /*  Container(
              margin: const EdgeInsets.only(right: 10),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  profileImage,
                ),
              ),
            ), */
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.search_rounded, color: Colors.white),
              ),
            ],
          ),
          body: Obx(
            () => controller.musicList.isEmpty
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.musicList.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 3),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: controller.playIndex.value == index &&
                                          controller.isPlaying.value
                                      ? const Color.fromARGB(122, 36, 36, 36)
                                      : const Color.fromARGB(26, 255, 255, 255),
                                ),
                                child: ListTile(
                                  title: Text(
                                    controller.musicList[index].title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: controller.playIndex.value ==
                                                    index &&
                                                controller.isPlaying.value
                                            ? greenColors
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    controller.musicList[index].artist
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: controller.playIndex.value ==
                                                    index &&
                                                controller.isPlaying.value
                                            ? greenColors
                                            : Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Roboto"),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(17, 255, 255, 255),
                                    child: controller.isPlaying.value &&
                                            controller.playIndex.value == index
                                        ? const Icon(Icons.pause)
                                        : QueryArtworkWidget(
                                            id: controller.musicList[index].id,
                                            type: ArtworkType.AUDIO,
                                            nullArtworkWidget: const Icon(
                                              Icons.music_note,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.menu_rounded,
                                        color: controller.playIndex.value ==
                                                    index &&
                                                controller.isPlaying.value
                                            ? greenColors
                                            : Colors.white),
                                  ),
                                  onTap: () {
                                    if (controller.isPlaying.value &&
                                        controller.playIndex.value == index) {
                                      Get.to(() => Player(),
                                          transition: Transition.downToUp,
                                          duration: const Duration(
                                              milliseconds: 400));
                                    } else {
                                      controller.playPlayList(index);

                                      Get.to(() => Player(),
                                          transition: Transition.downToUp,
                                          duration: const Duration(
                                              milliseconds: 400));
                                    }
                                  },
                                )),
                          ),
                        );
                      },
                    ),
                  ),
          )),
    );
  }
}
