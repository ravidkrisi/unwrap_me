// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:moving_box/domain/entities/prompt.dart';

abstract class GameState {}

// init
class GameInit extends GameState {}

// parcel moving
class ParcelMoving extends GameState {
  final Duration timeLeft;
  final Color backgroundColor;
  ParcelMoving({required this.timeLeft, required this.backgroundColor});
}

// parcel stopped
class ParcelStopped extends GameState {
  final Prompt prompt;
  ParcelStopped({required this.prompt});
}
