// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moving_box/domain/entities/prompt.dart';

abstract class GameEvent {}

class InitGame extends GameEvent {}

class StartGame extends GameEvent {
  final Genre genre;
  StartGame({required this.genre});
}

class ParcelPassed extends GameEvent {}

class TimerFinished extends GameEvent {}

class MissionCompleted extends GameEvent {}

class StopGame extends GameEvent {}

class ChangeBackgroundColor extends GameEvent {}
