import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/core/services/vibration.dart';
import 'package:moving_box/core/utils/color.dart';
import 'package:moving_box/core/services/sound.dart';
import 'package:moving_box/domain/repos/game_repo.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // services
  final GameRepo repo;
  final SoundEffect sound;
  final VibrationService vibration;

  // timers
  Timer? mainTimer;
  Timer? backgroundColorTimer;

  Future<String>? _futureMission;

  final Random _random = Random();

  GameBloc({required this.repo, required this.sound, required this.vibration})
    : super(GameInit()) {
    // register handlers
    on<StartGame>(_startGame);
    on<ParcelPassed>(_parcelPassed);
    on<TimerFinished>(_showMission);
    on<MissionCompleted>(_resumeGame);
    on<ChangeBackgroundColor>(_onChangeBackgroundColor);
  }

  void _startGame(StartGame event, Emitter<GameState> emit) {
    add(ParcelPassed());
  }

  void _parcelPassed(ParcelPassed event, Emitter<GameState> emit) {
    final seconds = 2 + _random.nextInt(15); // random 2-15 seconds
    final duration = Duration(seconds: seconds);

    final initColor = getRandomColor();

    emit(ParcelMoving(timeLeft: duration, backgroundColor: initColor));

    // get mission
    _futureMission = repo.getMission();

    // start main timer
    mainTimer?.cancel();
    mainTimer = Timer(duration, () {
      add(TimerFinished());
    });

    // play sound
    sound.playSound();

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
    sound.stopSound();
    // trigger vibration
    vibration.triggerVibration();
    // cancel timers
    backgroundColorTimer?.cancel();
    backgroundColorTimer = null;

    // get mission
    final mission = await _futureMission!;

    emit(ParcelStopped(mission: mission));
  }

  void _resumeGame(MissionCompleted event, Emitter<GameState> emit) {
    add(ParcelPassed());
  }
}
