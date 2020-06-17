// DESCRIPTION: Manager for the signin methods

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/services/auth.dart';

class SignInManager {
  SignInManager({
    @required this.auth,
  });

  final AuthBase auth;

  Future<void> createUser({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> singInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await auth.singInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  // Signin using external medium code
  Future<void> signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e);
    }
  }
}
