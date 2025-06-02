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
      backgroundColor: Colors.black, // Match launch screen background
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center everything vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // title
            Column(
              children: [
                Text(
                  'UNWRAP',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.3),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ).animate().slideX(
                  begin: -3,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOutCubic,
                ),
                // Text(
                //   'THE',
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //     shadows: [
                //       Shadow(
                //         color: Colors.white.withOpacity(0.3),
                //         offset: Offset(5, 5),
                //         blurRadius: 3,
                //       ),
                //     ],
                //   ),
                // ).animate().slideX(
                //   begin: 3,
                //   duration: const Duration(seconds: 1),
                //   curve: Curves.easeOutCubic,
                // ),
                Text(
                  'ME',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.3),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ).animate().slideX(
                  begin: 3,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOutCubic,
                ),
              ],
            ),

            const SizedBox(height: 40), // Add spacing
            // box image
            Image.asset('assets/images/box_image.png', height: 200)
                .animate()
                .scaleXY(duration: Duration(seconds: 1))
                .shake(
                  duration: Duration(milliseconds: 1300),
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: 40), // Add spacing
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

            const SizedBox(height: 20), // Add spacing
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
