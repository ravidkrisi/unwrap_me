import 'package:audioplayers/audioplayers.dart';

class SoundEffect {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    await _audioPlayer.play(AssetSource('sounds/parcel_move.wav'), volume: 1);
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }
}
