import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final _gameSoundFiles = [
    "sounds/parcel_move_1.wav",
    "sounds/parcel_move_2.wav",
    "sounds/parcel_move_3.wav",
  ];

  final Random _random = Random();

  Future<void> parcelMovingSound() async {
    await _audioPlayer.play(
      AssetSource(_gameSoundFiles[_random.nextInt(_gameSoundFiles.length)]),
      volume: 1,
    );
    loop();
  }

  Future<void> btnPressedSound() async {
    await _audioPlayer.play(AssetSource('sounds/btn_pressed.mp3'), volume: 1);
  }

  Future<void> parcelStoppedSound() async {
    stopLoop();
    await _audioPlayer.play(AssetSource('sounds/parcel_stop.wav'), volume: 1);
  }

  void loop() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void stopLoop() {
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }
}
