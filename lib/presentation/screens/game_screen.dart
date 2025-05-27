import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        builder: (context, state) {
          // parcel passed
          if (state is ParcelMoving) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: state.backgroundColor,
            );
          }

          // parcel stopped
          if (state is ParcelStopped) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.mission),
                  FilledButton(
                    onPressed: () {
                      context.read<GameBloc>().add(ParcelPassed());
                    },
                    child: Text('PASS'),
                  ),
                ],
              ),
            );
          }

          // default
          return Container();
        },
        listener: (context, state) {
          print(state);
        },
      ),
    );
  }
}
