import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/repositories/auth_repository.dart';
import 'package:scuba_sweep/utilities/enum.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final signInProvider =
    AutoDisposeAsyncNotifierProvider<SignInNotifier, void>(SignInNotifier.new);

class SignInNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    //
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<AuthResultStatus> signInWithCredential(credential) async {
    final authRepository = ref.read(authRepositoryProvider);
    try {
      return await authRepository.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthResultStatus> signInWithEmailAndPassword(
      String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    try {
      return await authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signOut();
  }
}
