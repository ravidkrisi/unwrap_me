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
      appBar: AppBar(),
      body: BlocConsumer<GameBloc, GameState>(
        builder: (context, state) {
          // parcel passed
          if (state is ParcelMoving) {
            return Center(child: Column(children: [Text('parcel is moving')]));
          }

          // parcel stopped
          if (state is ParcelStopped) {
            return Center(
              child: Column(
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
