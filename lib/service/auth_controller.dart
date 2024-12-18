import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'crud_controller.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Crud _crud = Crud();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<String?> createUserWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await addUsrToFireStore(credential.user!);

        return 'Account created successfully!';
      }
      return 'Account creation failed.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred.';
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return 'Sign-in successful!';
      } else {
        return 'No user found for this email.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        return 'invalid-credential';
      }
      return e.message ?? 'An unexpected error occurred.';
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addUsrToFireStore(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'uid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log('Error adding user to Firestore: $e');
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final loadingProvider = StateProvider<bool>((ref) => false);
