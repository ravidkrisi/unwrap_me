import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final Random _random = Random();

  final List<String> _prompts = [
    "You are a fun party game host. Give one random personal question that will make people laugh and share interesting stories about themselves.",
    "You are a creative party game host. Ask a hypothetical 'what would you do if...' question that sparks interesting discussions.",
    "You are a party game host. Give a funny 'would you rather' question with two equally entertaining options.",
    "You are a party game host. Ask a question about someone's past experiences that will reveal something surprising or amusing.",
    "You are a party game host. Give a creative question about future aspirations or dreams that will entertain the group.",
    "You are a party game host. Ask a question about preferences (food, movies, travel, etc.) but make it quirky and unexpected.",
    "You are a party game host. Give a question about childhood memories that will make people laugh and share funny stories.",
    "You are a party game host. Ask a question about superpowers or magical abilities that leads to entertaining discussions.",
    "You are a party game host. Give a question about unusual talents or hidden skills that people might have.",
    "You are a party game host. Ask a question about embarrassing moments or funny mishaps that people are willing to share.",
  ];

  Future<String?> getNextQuestion() async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final selectedPrompt = _prompts[_random.nextInt(_prompts.length)];
    print(selectedPrompt);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": selectedPrompt},
          {"role": "user", "content": "Give me the next question."},
        ],
        "temperature": 0.9,
        "max_tokens": 60,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }
}
