// import 'package:get_it/get_it.dart';
// import 'package:moving_box/core/services/openai_service.dart';
import 'package:moving_box/core/services/prompts_service.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/services/vibration_service.dart';
import 'package:moving_box/domain/entities/prompt.dart';
import 'package:moving_box/domain/repos/game_repo.dart';

class GameRepoImpl implements GameRepo {
  @override
  final PromptService promptService;
  final SoundService soundService;
  final VibrationService vibrationService;

  GameRepoImpl({
    required this.promptService,
    required this.soundService,
    required this.vibrationService,
  });

  @override
  Prompt? getPrompt() {
    final prompt = promptService.getRandomPrompt();
    return prompt;
  }

  @override
  Future<void> loadPrompts() async {
    try {
      await promptService.loadPrompts();
    } catch (e, stackTrace) {
      print('loadPrompts error: $e');
      print(stackTrace);
      throw Exception("failed to load prompts: $stackTrace");
    }
  }

  @override
  Prompt? getPromptByGenre(Genre genre) {
    final prompt = promptService.getRandomPromptByGenre(genre);
    return prompt;
  }

  @override
  Future<void> playSound() async {
    await soundService.parcelMovingSound();
  }

  @override
  Future<void> stopSound() async {
    await soundService.stopSound();
    await soundService.parcelStoppedSound();
  }

  @override
  void triggerVibration() {
    vibrationService.triggerVibration();
  }
}
