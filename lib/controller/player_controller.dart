import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var musicList = RxList<SongModel>();
  var duration = ''.obs;
  var position = ''.obs;
  var durationValue = 0.0.obs;
  var positionValue = 0.0.obs;
  // end 0 -  repeat 1 - go through playlist 2 -repeat list 3
  var mode = 0.obs;
  var playlist = ConcatenatingAudioSource(children: []).obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  void changeMode(int newmode) {
    mode(newmode);
  }

  seekSlider(seconds) {
    var sliderduration = Duration(seconds: seconds);
    audioPlayer.seek(sliderduration);
  }

  updatePosition() {
    audioPlayer.durationStream.listen((event) {
      duration.value = event.toString().split('.')[0];
      durationValue.value = event!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((event) {
      position.value = event.toString().split('.')[0];
      positionValue.value = event.inSeconds.toDouble();
      /* if (positionValue.value == durationValue.value &&
          audioPlayer.playing &&
          mode.value == 0) {
        positionValue.value = 0;
      }
      if (positionValue.value == durationValue.value &&
          audioPlayer.playing &&
          mode.value == 2 &&
          playIndex.value == musicList.length - 1) {
        positionValue.value = 0;
      } */
    });
  }

  checkState() {
    audioPlayer.currentIndexStream.listen((event) {
      playIndex.value = event!;
    });
  }

  query() async {
    var a = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL);
    musicList.assignAll(a);
    createPlaylist(musicList);
  }

  stopSong() {
    playIndex.value = 0;
    try {
      audioPlayer.stop();
      isPlaying(false);
    } catch (e) {
      print(e.toString());
    }
  }

  resumeSong() {
    try {
      audioPlayer.play();
      if (positionValue.value == 0) {
        var uri = musicList[playIndex.value].uri;
        audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      }
      isPlaying(true);
    } catch (e) {}
  }

  pauseSong() {
    try {
      audioPlayer.pause();
      isPlaying(false);
    } catch (e) {
      print(e.toString());
    }
  }

  playPlayList(index) async {
    playIndex.value = index;
    audioPlayer.setAudioSource(
      playlist.value,
      initialIndex: index,
      initialPosition: Duration.zero,
    );
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer.play();
    isPlaying(true);
    updatePosition();
    checkState();
  }

  playSong(index) async {
    print('thi is index  $index');
    playIndex.value = index;
    try {
      var uri = musicList[index].uri;
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      checkState();
      updatePosition();
    } catch (e) {
      print(e.toString());
    }
  }
  /* Future<void> playSong(index) async {
    playIndex.value = index;
    var uri = musicList[index].uri;
    await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    await audioPlayer.play();
    isPlaying(true);
   

    updatePosition();
  } */

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      query();
    } else {
      checkPermission();
    }
  }

  createPlaylist(List<SongModel> list) {
    var l = ConcatenatingAudioSource(
      // Start loading next item just before reaching it

      // Specify the playlist items
      children: list
          .map((e) => AudioSource.uri(Uri.parse(e.uri.toString())))
          .toList(),
      /* AudioSource.uri(Uri.parse('https://example.com/track1.mp3')),
        AudioSource.uri(Uri.parse('https://example.com/track2.mp3')),
        AudioSource.uri(Uri.parse('https://example.com/track3.mp3')), */
    );
    playlist.value = l;
    print(l);
  }
}
