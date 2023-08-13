import 'package:flutter/material.dart';
import 'package:flutter_music_app/constant/colors.dart';
import 'package:flutter_music_app/constant/text_style.dart';
import 'package:flutter_music_app/controller/player_controller.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.deepPurple.shade800.withOpacity(0.8),
        Colors.deepPurple.shade200.withOpacity(0.8)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
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
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(129, 255, 255, 255)),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Song Found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(26, 255, 255, 255),
                        ),
                        child: const ListTile(
                            title: Text(
                              'Music Name',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Music Name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 218, 211, 211),
                                fontSize: 12,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(17, 255, 255, 255),
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                            ),
                            trailing:
                                Icon(Icons.play_circle, color: Colors.white))),
                  );
                },
              ),
            );
          },
          future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL),
        ),
      ),
    );
  }
}
