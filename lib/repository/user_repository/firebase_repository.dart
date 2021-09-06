import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/repository/user_repository.dart';

/// Registration and authentication via Firebase
class FirebaseUserRepository extends UserRepository {
  FirebaseUserRepository();

  /// Email of the signed user
  @override
  String get signedEmail {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email! ?? "";
  }

  /// Authentication on Firebase with username and password
  @override
  Future<bool> authenticate(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  /// Registration on Firebase with username and password
  @override
  Future<bool> register(String username, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  /// Logout from Firebase
  @override
  Future<void> logOut() => FirebaseAuth.instance.signOut();

  // @override
  // Future<User> getUser() async {
  //   return await FirebaseAuth.instance.currentUser;
  // }

  // @override
  // Future<bool> isLoggedIn() async {
  //   return await FirebaseAuth.instance.currentUser != null;
  // }
}
