import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/data/models/score_info_model.dart';

class GameRepository {
  GameRepository(this._firestore, this._auth);
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<void> saveHighScore(int score, String nickname) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      if (nickname.isNotEmpty) {
        await _firestore.collection('highScores').doc(userId).set({
          'score': score,
          'nickname': nickname,
        });
      } else {
        await _firestore.collection('highScores').doc(userId).set({
          'score': score,
        });
      }
    }
  }

  Future<int?> getHighScore() async {
    final userId = _auth.currentUser?.uid;
    final isAnonymous = _auth.currentUser?.isAnonymous ?? true;
    if (!isAnonymous && userId != null) {
      final doc = await _firestore.collection('highScores').doc(userId).get();
      if (doc.exists) {
        return doc.data()?['score'];
      }
    }
    return null;
  }

  Future<List<ScoreInfo>> getTopHighScores() async {
    final querySnapshot = await _firestore
        .collection('highScores')
        .orderBy('score', descending: true)
        .limit(3)
        .get();
    return querySnapshot.docs
        .map<ScoreInfo>((doc) => ScoreInfo.fromJson(doc.data()))
        .toList();
  }
}
