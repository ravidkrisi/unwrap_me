import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/core/utils/color.dart';
import 'package:moving_box/domain/entities/prompt.dart';
import 'package:moving_box/domain/repos/game_repo.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // services
  final GameRepo repo;
  // final SoundService sound;
  // final VibrationService vibration;

  // timers
  Timer? mainTimer;
  Timer? backgroundColorTimer;

  Prompt? _prompt;
  Genre? _genre;

  final Random _random = Random();

  GameBloc({required this.repo}) : super(GameInit()) {
    // register handlers
    on<StartGame>(_startGame);
    on<InitGame>(_initGame);
    on<ParcelPassed>(_parcelPassed);
    on<TimerFinished>(_showMission);
    on<MissionCompleted>(_resumeGame);
    on<ChangeBackgroundColor>(_onChangeBackgroundColor);
  }

  void _initGame(InitGame event, Emitter<GameState> emit) async {
    await repo.loadPrompts();
  }

  void _startGame(StartGame event, Emitter<GameState> emit) async {
    _genre = event.genre;
    print(_genre);
    add(ParcelPassed());
  }

  void _parcelPassed(ParcelPassed event, Emitter<GameState> emit) {
    final seconds = 3 + _random.nextInt(15); // random 2-15 seconds
    final duration = Duration(seconds: seconds);

    final initColor = getRandomColor();

    emit(ParcelMoving(timeLeft: duration, backgroundColor: initColor));

    // get mission
    _prompt = repo.getPromptByGenre(_genre ?? Genre.friends);
    print(_prompt);

    // start main timer
    mainTimer?.cancel();
    mainTimer = Timer(duration, () {
      add(TimerFinished());
    });

    // play sound
    repo.playSound();

    // start background color timer
    backgroundColorTimer?.cancel();
    backgroundColorTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      final currState = state;
      if (currState is ParcelMoving) {
        add(ChangeBackgroundColor());
      } else {
        timer.cancel();
      }
    });
  }

  void _onChangeBackgroundColor(
    ChangeBackgroundColor event,
    Emitter<GameState> emit,
  ) {
    final currState = state;
    if (currState is ParcelMoving) {
      final newColor = getRandomColor();
      emit(
        ParcelMoving(timeLeft: currState.timeLeft, backgroundColor: newColor),
      );
    }
  }

  void _showMission(TimerFinished event, Emitter<GameState> emit) async {
    // stop sound
    repo.stopSound();
    // trigger vibration
    repo.triggerVibration();
    // cancel timers
    backgroundColorTimer?.cancel();
    backgroundColorTimer = null;

    // prompt is null -> end of game
    print(_prompt);
    if (_prompt == null) {
      add(StopGame());
      return;
    }
    // prompt available
    else {
      emit(ParcelStopped(prompt: _prompt!));
    }
  }

  void _resumeGame(MissionCompleted event, Emitter<GameState> emit) {
    add(ParcelPassed());
  }
}
