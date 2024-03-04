import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scuba_sweep/data/repositories/open_ai_repository.dart';

part 'message_provider.freezed.dart';

@freezed
class AiMessageState with _$AiMessageState {
  const factory AiMessageState({
    @Default('') String message,
    @Default(false) bool isLoading,
  }) = _AiMessageState;

  const AiMessageState._();
}

final openAiProvider = Provider<OpenAI>((ref) => OpenAI.instance);

final openAiRepositoryProvider = Provider<OpenAiRepository>((ref) {
  return OpenAiRepository(ref.watch(openAiProvider));
});

final aiMessageNotifierProvider =
    StateNotifierProvider<AiMessageNotifier, AiMessageState>(
  (ref) => AiMessageNotifier(ref.read(openAiRepositoryProvider)),
);

class AiMessageNotifier extends StateNotifier<AiMessageState> {
  final OpenAiRepository _openAiRepository;

  AiMessageNotifier(this._openAiRepository)
      : super(const AiMessageState(message: ''));

  Future<void> getAiMessage() async {
    state = state.copyWith(isLoading: true);
    try {
      final message = await _openAiRepository.askOpenAi();
      state = state.copyWith(message: message ?? '', isLoading: false);
    } catch (e) {
      return Future.error(e);
    }
  }
}
