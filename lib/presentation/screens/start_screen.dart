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
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ).animate().slideX(
                  begin: -3, // Start further left
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOutCubic,
                ),
                Text(
                  'THE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        offset: Offset(5, 5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ).animate().slideX(
                  begin: 3, // Start further left
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOutCubic,
                ),
                Text(
                  'PARCEL',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ).animate().slideX(
                  begin: -3, // Start further left
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOutCubic,
                ),
              ],
            ),

            // box image
            Image.asset('assets/images/box_image.png', height: 200)
                .animate()
                .scaleXY(duration: Duration(seconds: 1))
                .shake(
                  duration: Duration(milliseconds: 1300),
                  curve: Curves.easeOut,
                )
                .rotate(delay: Duration(seconds: 2)),

            // play btn
            MyButton(
              title: 'START GAME',
              onPressed: () {
                context.read<GameBloc>().add(StartGame());
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => GameScreen()));
              },
            ).animate().fadeIn(duration: Duration(seconds: 1)),

            // options btn
            MyButton(
              title: 'OPTIONS',
              onPressed: () {},
            ).animate().fadeIn(duration: Duration(seconds: 1)),
          ],
        ),
      ),
    );
  }
}
