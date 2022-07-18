import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/utils.dart';

class PlayerStateProvider with ChangeNotifier {
  bool isPlaying;
  bool isLoading;
  late AudioPlayer player;
  late AudioSource source;
  late String url;
  PlayerStateProvider({required this.isPlaying, required this.isLoading});

  void setUrl(String val) {
    url = val;
  }

  Future<void> initPlayer() async {
    source = AudioSource.uri(
      Uri.parse(url),
      tag: MediaItem(
        id: '1',
        title: "Jhumo Radio Rajasthan",
        album: "Dhadkan Rajasthan Ri",
        artUri: Uri.parse(
            'https://firebasestorage.googleapis.com/v0/b/jhumo-radio.appspot.com/o/icon.png?alt=media'),
      ),
    );
    player = AudioPlayer();
    var _ = await player.setAudioSource(source);
    await player.seek(null);
    await player.play();
  }

  void disposePlayer() {
    player.dispose();
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> softStop() async {
    await player.pause();
    await player.seek(null);
  }

  Future<void> hardStop() async {
    await player.stop();
  }

  void setPlaying(bool playing) {
    isPlaying = playing;
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void playerStreamListener() {
    player.playerStateStream.listen((state) {
      if (!state.playing) {
        setLoading(false);
        setPlaying(false);
      }
      if (!state.playing && player.processingState == ProcessingState.loading) {
        setLoading(true);
        setPlaying(false);
      }
      if (state.playing &&
          player.processingState == ProcessingState.buffering) {
        setLoading(true);
        setPlaying(false);
      }
      if (state.playing && player.processingState == ProcessingState.loading) {
        setLoading(true);
        setPlaying(false);
      }
      if (state.playing && player.processingState == ProcessingState.ready) {
        setLoading(false);
        setPlaying(true);
      }
    });
  }

  Future<void> errorAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
            title: Text(serverErrorAleartHeader),
            content: SingleChildScrollView(
              child: Text(serverErrorAleartBody),
            ));
      },
    );
  }
}
