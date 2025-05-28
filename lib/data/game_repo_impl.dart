import 'package:get_it/get_it.dart';
import 'package:moving_box/core/services/openai_service.dart';
import 'package:moving_box/domain/repos/game_repo.dart';

class GameRepoImpl implements GameRepo {
  final _openAIService = GetIt.instance<OpenAIService>();
  @override
  Future<String> getMission() async {
    try {
      final mission = await _openAIService.getNextQuestion();
      if (mission != null) {
        return mission;
      } else {
        return 'What is your favourite movie';
      }
    } catch (e) {
      throw Exception('failed to get mission');
    }
  }
}
