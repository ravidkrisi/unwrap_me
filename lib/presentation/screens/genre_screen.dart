import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/utils/service_locator.dart';
import 'package:moving_box/domain/entities/prompt.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/components/my_button.dart';
import 'package:moving_box/presentation/screens/game_screen.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            // play sound
            getIt<SoundService>().btnPressedSound();
            // go back to start screen
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RotatedBox(
              quarterTurns: 2,
              child: Image.asset(
                'assets/images/arrow_white_pixel.png',
                height: 12,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CHOOSE GENRE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Column(
              children:
                  Genre.values
                      .map(
                        (value) => Column(
                          children: [
                            SizedBox(
                              width: 300,
                              height: 55,
                              child: MyButton(
                                title: value.name.toUpperCase(),
                                onPressed: () {
                                  // play sound
                                  getIt<SoundService>().btnPressedSound();

                                  // navigate to game screen
                                  context.read<GameBloc>().add(
                                    StartGame(genre: value),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => GameScreen(),
                                    ),
                                  );
                                },
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
