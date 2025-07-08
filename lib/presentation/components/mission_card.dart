//
import 'package:flutter/material.dart';
import 'package:moving_box/core/services/sound_service.dart';
import 'package:moving_box/core/utils/service_locator.dart';
import 'package:moving_box/domain/entities/prompt.dart';

class MissionCard extends StatelessWidget {
  final Prompt prompt;
  final VoidCallback onPass;

  const MissionCard({super.key, required this.prompt, required this.onPass});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.height * 0.65,
        maxWidth: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          border: Border.all(color: Colors.deepPurple, width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // back button
              Positioned(
                top: 0,
                left: 0,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: GestureDetector(
                    onTap: () {
                      // play sound
                      getIt<SoundService>().btnPressedSound();
                      // go back to genre screen
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/images/arrow_pixel.png',
                      height: 25,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  prompt.type.toLowerCase() == 'truth'
                      ? Image.asset(
                        'assets/images/question_mark_pixel.png',
                        height: 30,
                      )
                      : Image.asset(
                        'assets/images/exclamation_mark_pixel.png',
                        height: 30,
                      ),

                  const SizedBox(height: 16),

                  // prompt text
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      prompt.prompt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // pass btn
                  FilledButton(
                    onPressed: onPass,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.zero,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('PASS', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
