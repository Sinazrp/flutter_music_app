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

  @override
  void onInit() {
    super.onInit();
    checkPermission();
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
      if (positionValue.value == durationValue.value && audioPlayer.playing) {
        positionValue.value = 0;
      }
    });
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying(false);
      }
    });
  }

  query() async {
    var a = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL);
    musicList.assignAll(a);
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

  playSong(index) {
    playIndex.value = index;
    try {
      var uri = musicList[index].uri;
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
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
}
