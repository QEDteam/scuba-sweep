import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_app/data/models/score_info_model.dart';
import 'package:my_flutter_app/data/providers/auth_provider.dart';
import 'package:my_flutter_app/data/repositories/game_repository.dart';

part 'score_provider.freezed.dart';

@freezed
class ScoreState with _$ScoreState {
  const factory ScoreState({
    @Default(0) int score,
    @Default(0) int highScore,
    @Default([]) List<ScoreInfo> topHighScores,
    @Default(false) bool isLoading,
    @Default('') String nickname,
  }) = _ScoreState;

  const ScoreState._();
}

final scoreNotifierProvider = StateNotifierProvider<ScoreNotifier, ScoreState>(
  (ref) => ScoreNotifier(ref.read(gameRepositoryProvider), ref),
);

class ScoreNotifier extends StateNotifier<ScoreState> {
  final GameRepository _gameRepository;
  Ref ref;

  ScoreNotifier(this._gameRepository, this.ref) : super(const ScoreState());

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  Future<void> loadScores(int currentScore) async {
    state = state.copyWith(score: currentScore);
    if (currentScore > state.highScore) {
      await saveHighScore(currentScore);
    }
    await getTopHighScores();
  }

  Future<void> getHighScore() async {
    state = state.copyWith(isLoading: true);
    try {
      final highScore = await _gameRepository.getHighScore();
      state = state.copyWith(highScore: highScore ?? 0, isLoading: false);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> saveHighScore(int score) async {
    try {
      await _gameRepository.saveHighScore(score, state.nickname);
      state = state.copyWith(highScore: score, isLoading: false);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> getTopHighScores() async {
    try {
      final topHighScores = await _gameRepository.getTopHighScores();
      state = state.copyWith(topHighScores: topHighScores, isLoading: false);
    } catch (e) {
      return Future.error(e);
    }
  }
}

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider),
  );
});
