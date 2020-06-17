import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/services/api_path.dart';

class User {
  User(
      {@required this.uid,
      @required this.email,
      @required this.displayName,
      @required this.photoURL,
      @required this.phoneNumber});

  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String photoURL;
}

abstract class AuthBase {
  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> singInWithEmailAndPassword({String email, String password});

  Future<void> signOut();

  Stream<User> get onAuthStateChanged;

  Future<User> createUserWithEmailAndPassword({String email, String password});
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreInstance = Firestore.instance;

  User _userFromFirebase(FirebaseUser user) {
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoUrl,
      phoneNumber: user.phoneNumber,
    );
  }

  Future<void> _addUserInfo({UserDetails data, User user}) async {
    final documentReference = _firestoreInstance.document(
      APIPath.setUserInfo(uid: user.uid),
    );
    UserDetails userDetails;
    if (data == null) {
      userDetails = UserDetails(
        uid: user.uid,
        email: user.email,
      );
    } else {
      userDetails = UserDetails(
        uid: user.uid,
        email: user.email,
        displayName: data.displayName,
        hostel: data.hostel,
        branch: data.branch,
        mobileNo: data.mobileNo,
        year: data.year,
        rollNo: data.rollNo,
      );
    }
    await documentReference.updateData(userDetails.toMap());
  }

  Future<void> _checkUserInfo({User user}) async {
    final DocumentReference reference =
        Firestore.instance.document(APIPath.getUserInfo(uid: user.uid));
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    final snapshot = snapshots.map((snapshot) =>
        UserDetails.fromMap(value: snapshot.data, id: snapshot.documentID));
    snapshot.listen((event) {
      _addUserInfo(user: user, data: event);
    });
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        await _checkUserInfo(user: _userFromFirebase(authResult.user));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google auth token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Login aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(
      ['email'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      await _checkUserInfo(user: _userFromFirebase(authResult.user));
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> singInWithEmailAndPassword(
      {String email, String password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    await _checkUserInfo(user: _userFromFirebase(authResult.user));
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _checkUserInfo(user: _userFromFirebase(authResult.user));
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final facebookSignIn = FacebookLogin();
    await facebookSignIn.logOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
