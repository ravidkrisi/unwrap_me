import 'package:vibration/vibration.dart';

class VibrationService {
  void triggerVibration() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 500); // vibrate for 500ms
    }
  }
}
