import 'package:get_it/get_it.dart';
import 'package:moving_box/core/services/openai_service.dart';
import 'package:moving_box/core/services/sound.dart';
import 'package:moving_box/data/game_repo_impl.dart';
import 'package:moving_box/domain/repos/game_repo.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // services
  getIt.registerLazySingleton<SoundEffect>(() => SoundEffect());
  getIt.registerLazySingleton<OpenAIService>(() => OpenAIService());

  // repos
  getIt.registerLazySingleton<GameRepo>(() => GameRepoImpl());

  // blocs
  getIt.registerLazySingleton<GameBloc>(
    () => GameBloc(repo: getIt(), sound: getIt()),
  );
}
