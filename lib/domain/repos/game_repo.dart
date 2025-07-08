// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moving_box/core/services/prompts_service.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/services/vibration_service.dart';
import 'package:moving_box/domain/entities/prompt.dart';

abstract class GameRepo {
  // services
  final PromptService promptService;
  final SoundService soundService;
  final VibrationService vibrationService;

  GameRepo({
    required this.promptService,
    required this.soundService,
    required this.vibrationService,
  });

  // get prompt
  Prompt? getPrompt();

  // get prompt by genre
  Prompt? getPromptByGenre(Genre genre);

  // load prompts
  Future<void> loadPrompts();

  // play sound
  Future<void> playSound();

  // stop sound
  Future<void> stopSound();

  // vibrate
  void triggerVibration();
}
