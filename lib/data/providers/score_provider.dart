import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scuba_sweep/data/models/score_info_model.dart';
import 'package:scuba_sweep/data/providers/auth_provider.dart';
import 'package:scuba_sweep/data/repositories/game_repository.dart';

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

  Future<String> getNickname() async {
    if (state.nickname == '') {
      state = state.copyWith(isLoading: true);
      try {
        await _gameRepository.getNickname().then((value) {
          state = state.copyWith(nickname: value, isLoading: false);
        });
      } catch (e) {
        return Future.error(e);
      }
    }
    return state.nickname;
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
    saveNickname(nickname);
  }

  Future<void> saveNickname(String nickname) async {
    try {
      await _gameRepository.saveNickname(nickname);
      state = state.copyWith(nickname: nickname);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> loadScores() async {
    final currentScore = state.score;
    if (currentScore > state.highScore) {
      await saveHighScore(currentScore);
    }
    await getTopHighScores();
  }

  Future<void> getHighScore() async {
    state = state.copyWith(isLoading: true);
    try {
      final ScoreInfo? highScore = await _gameRepository.getHighScore();
      if (highScore != null) {
        state = state.copyWith(
            highScore: highScore.score,
            nickname: highScore.nickname ?? '',
            isLoading: false);
        return;
      } else {
        state = state.copyWith(highScore: 0, isLoading: false, nickname: '');
        return;
      }
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

  resetScore() {
    state = state.copyWith(score: 0);
  }

  bool encreaseScore() {
    state = state.copyWith(score: state.score + 1);
    return state.score % 10 == 0;
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
