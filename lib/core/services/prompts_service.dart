import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moving_box/domain/entities/prompt.dart';

class PromptService {
  final FirebaseFirestore _firestore;
  final List<Prompt> _allPrompts = [];
  final Set<String> _usedPromptIds = {};

  PromptService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetch all prompts once at the start of the game
  Future<void> loadPrompts() async {
    final snapshot = await _firestore.collection('prompts').get();
    _allPrompts.clear();
    _usedPromptIds.clear();

    for (final doc in snapshot.docs) {
      try {
        final prompt = Prompt.fromMap(doc.data());
        _allPrompts.add(prompt);
      } catch (e) {
        print('❌ Failed to parse document with ID: ${doc.id}');
        print('Raw data: ${doc.data()}');
        print('Error: $e\n');
      }
    }
  }

  /// Get one random unused prompt
  Prompt? getRandomPrompt() {
    final unusedPrompts =
        _allPrompts
            .where((prompt) => !_usedPromptIds.contains(prompt.id))
            .toList();

    if (unusedPrompts.isEmpty) return null; // No more unused prompts

    final random = Random();
    final prompt = unusedPrompts[random.nextInt(unusedPrompts.length)];

    _usedPromptIds.add(prompt.id); // mark as used
    return prompt;
  }

  // get random prompt by genre
  Prompt? getRandomPromptByGenre(Genre genre) {
    final filteredPrompts =
        _allPrompts
            .where(
              (prompt) =>
                  prompt.genre == genre && !_usedPromptIds.contains(prompt.id),
            )
            .toList();

    if (filteredPrompts.isEmpty) return null;

    final random = Random();
    final prompt = filteredPrompts[random.nextInt(filteredPrompts.length)];

    _usedPromptIds.add(prompt.id);
    return prompt;
  }

  // reset between game runs
  void resetGame() {
    _usedPromptIds.clear();
  }
}
