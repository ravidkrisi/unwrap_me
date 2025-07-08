import 'package:vibration/vibration.dart';

class VibrationService {
  void triggerVibration() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 1500); // vibrate for 500ms
    }
  }
}
