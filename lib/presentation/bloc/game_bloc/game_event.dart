abstract class GameEvent {}

class StartGame extends GameEvent {}

class ParcelPassed extends GameEvent {}

class TimerFinished extends GameEvent {}

class MissionCompleted extends GameEvent {}

class StopGame extends GameEvent {}

class ChangeBackgroundColor extends GameEvent {}
