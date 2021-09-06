import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet_app/repository/user_repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  UserRepository();

  /// Email of the signed user
  String get signedEmail;

  /// Login with usernamne and password
  Future<bool> authenticate(String username, String password);

  /// Register with username and password
  Future<bool> register(String username, String password);

  /// Logout
  Future<void> logOut();

  ///Check Logged In
  // Future<bool> isLoggedIn();

  // /// Get Current user
  // Future<User> getUser();
}
