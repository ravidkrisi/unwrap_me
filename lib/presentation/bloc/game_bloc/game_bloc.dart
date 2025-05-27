import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? timer;
  final List<String> missions;
  final Random _random = Random();

  GameBloc({required this.missions}) : super(GameInit()) {
    // register handlers
    on<StartGame>(_startGame);
    on<ParcelPassed>(_parcelPassed);
    on<TimerFinished>(_showMission);
    on<MissionCompleted>(_resumeGame);
  }

  void _startGame(StartGame event, Emitter<GameState> emit) {
    add(ParcelPassed());
  }

  void _parcelPassed(ParcelPassed event, Emitter<GameState> emit) {
    final seconds = 2 + _random.nextInt(15); // random 2-15 seconds
    final duration = Duration(seconds: seconds);

    emit(ParcelMoving(timeLeft: duration));

    timer?.cancel();
    timer = Timer(duration, () {
      add(TimerFinished());
    });
  }

  void _showMission(TimerFinished event, Emitter<GameState> emit) {
    missions.shuffle();
    final mission = missions.removeAt(0);

    emit(ParcelStopped(mission: mission));
  }

  void _resumeGame(MissionCompleted event, Emitter<GameState> emit) {
    add(ParcelPassed());
  }
}
