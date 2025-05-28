import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/components/my_button.dart';
import 'package:moving_box/presentation/screens/game_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // title
            Column(
              children: [
                Text(
                  'PASS',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ).animate().slideX(begin: -1),
                Text(
                  'THE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ).animate().slideX(begin: 1),
                Text(
                  'PARCEL',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ).animate().slideX(begin: -1),
              ],
            ),

            // box image
            Image.asset(
              'assets/images/box_image.png',
              height: 200,
            ).animate().scaleXY(),

            // play btn
            MyButton(
              title: 'Start Game',
              onPressed: () {
                context.read<GameBloc>().add(StartGame());
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => GameScreen()));
              },
            ),

            // options btn
            MyButton(title: 'Options', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
