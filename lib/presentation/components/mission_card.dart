//
import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  final String mission;
  final VoidCallback onPass;

  const MissionCard({super.key, required this.mission, required this.onPass});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.9,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: Colors.deepPurple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.question_mark_rounded,
                  size: 48,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                Text(
                  mission,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onPass,
                  icon: Icon(Icons.send_rounded),
                  label: Text('PASS'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
