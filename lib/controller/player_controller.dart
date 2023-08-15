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
  //   repeat 0 - go through playlist 1 -repeat list 2
  var mode = 0.obs;
  var playlist = ConcatenatingAudioSource(children: []).obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    ever(mode, (callback) {
      if (callback == 0) {
        audioPlayer.setLoopMode(LoopMode.one);
      } else if (callback == 1) {
        audioPlayer.setLoopMode(LoopMode.off);
      } else if (callback == 2) {
        audioPlayer.setLoopMode(LoopMode.all);
      }
    });
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
      if (positionValue.value == durationValue.value && mode.value == 1) {
        positionValue.value = 0;
      }
    });
  }

  checkState() {
    audioPlayer.currentIndexStream.listen((event) {
      playIndex.value = event!;
    });
    audioPlayer.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
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
    createPlaylist(musicList);
  }

  stopSong() {
    playIndex.value = 0;

    audioPlayer.stop();
    isPlaying(false);
  }

  resumeSong() {
    if (audioPlayer.processingState == ProcessingState.completed &&
        mode.value == 1 &&
        positionValue.value == 0) {
      audioPlayer.setLoopMode(LoopMode.off);

      playPlayList(playIndex.value);
      isPlaying(true);
    }

    audioPlayer.play();
    isPlaying(true);
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
    if (mode.value == 0) {
      audioPlayer.setLoopMode(LoopMode.one);
    } else if (mode.value == 1) {
      audioPlayer.setLoopMode(LoopMode.off);
    } else {
      audioPlayer.setLoopMode(LoopMode.all);
    }

    audioPlayer.play();
    isPlaying(true);
    updatePosition();
    checkState();
  }

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
      children: list
          .map((e) => AudioSource.uri(Uri.parse(e.uri.toString())))
          .toList(),
    );
    playlist.value = l;
  }
}
