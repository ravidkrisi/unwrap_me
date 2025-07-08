import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/utils/service_locator.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/components/my_button.dart';
import 'package:moving_box/presentation/screens/genre_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger event on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameBloc>().add(InitGame());
    });

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

            // box image
            Image.asset('assets/images/box_image_pixel.png', height: 300)
                .animate()
                .scaleXY(duration: Duration(seconds: 1))
                .shake(
                  duration: Duration(milliseconds: 1300),
                  curve: Curves.easeOut,
                ),

            // start game btn
            SizedBox(
              height: 55,
              child: MyButton(
                title: 'START GAME',
                fontSize: 12,
                onPressed: () {
                  // play sound
                  getIt<SoundService>().btnPressedSound();

                  // navigate to genre screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GenreScreen()),
                  );
                },
              ).animate().fadeIn(duration: Duration(seconds: 1)),
            ),

            const SizedBox(height: 20), // Add spacing
          ],
        ),
      ),
    );
  }
}
