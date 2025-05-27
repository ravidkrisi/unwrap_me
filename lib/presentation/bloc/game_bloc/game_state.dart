// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class GameState {}

// init
class GameInit extends GameState {}

// parcel moving
class ParcelMoving extends GameState {
  final Duration timeLeft;
  ParcelMoving({required this.timeLeft});
}

// parcel stopped
class ParcelStopped extends GameState {
  final String mission;
  ParcelStopped({required this.mission});
}
