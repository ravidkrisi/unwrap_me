// ignore_for_file: public_member_api_docs, sort_constructors_first

class Prompt {
  final String id;
  final Genre genre;
  final String type;
  final String prompt;

  Prompt({
    required this.id,
    required this.genre,
    required this.type,
    required this.prompt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'genre': genre.toString(),
      'type': type,
      'prompt': prompt,
    };
  }

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      id: map['id'] as String,
      genre: Genre.values.byName((map['genre'] as String).toLowerCase()),
      type: map['type'] as String,
      prompt: map['prompt'] as String,
    );
  }
}

enum Genre {
  friends,
  drinking,
  couples;

  String emoji() {
    switch (this) {
      case Genre.couples:
        return "revolving_hearts";
      case Genre.drinking:
        return "clinking_glasses";
      case Genre.friends:
        return "people_holding_hands";
    }
  }
}
