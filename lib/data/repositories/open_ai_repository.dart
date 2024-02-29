import 'dart:convert';
import 'dart:math';

import 'package:dart_openai/dart_openai.dart';

class OpenAiRepository {
  OpenAiRepository(this._openAi);
  final OpenAI _openAi;

  OpenAIChatCompletionChoiceMessageModel userMessage =
      OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        environmentalPrompt,
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  OpenAIChatCompletionChoiceMessageModel systemMessage =
      OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "return any message you are given as JSON.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  Future<String?> askOpenAi() async {
    final requestMessages = [
      userMessage,
      systemMessage,
    ];
    final Random random = Random();
    final int seed = random.nextInt(10000);
    try {
      OpenAIChatCompletionModel chatCompletion = await _openAi.chat.create(
        model: "gpt-3.5-turbo-1106",
        responseFormat: {"type": "json_object"},
        seed: seed,
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: 500,
      );
      final message = chatCompletion.choices.first.message;
      String? jsonString = message.content!.first.text;
      Map<String, dynamic> jsonMap = json.decode(jsonString!);
      String actualMessage = jsonMap["message"];
      return actualMessage;
    } catch (_) {
      return null;
    }
  }
}

const String environmentalPrompt =
    "Generate a short message to raise awareness about environmental conservation. Please without hashtags or links.";
