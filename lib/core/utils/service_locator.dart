import 'package:get_it/get_it.dart';
import 'package:moving_box/core/services/openai_service.dart';
import 'package:moving_box/core/services/prompts_service.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/services/vibration_service.dart';
import 'package:moving_box/data/game_repo_impl.dart';
import 'package:moving_box/domain/repos/game_repo.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // services
  getIt.registerLazySingleton<SoundService>(() => SoundService());
  getIt.registerLazySingleton<OpenAIService>(() => OpenAIService());
  getIt.registerLazySingleton<VibrationService>(() => VibrationService());
  getIt.registerLazySingleton<PromptService>(() => PromptService());

  // repos
  getIt.registerLazySingleton<GameRepo>(
    () => GameRepoImpl(
      promptService: getIt(),
      soundService: getIt(),
      vibrationService: getIt(),
    ),
  );

  // blocs
  getIt.registerLazySingleton<GameBloc>(() => GameBloc(repo: getIt()));
}
