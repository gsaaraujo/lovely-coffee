import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/app/constants/error_strings.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/modules/auth/data/faults/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

abstract class IUserDatasource {
  Future<UserSignedInEntity> googleSignIn();
}

class UserDatasourceImpl implements IUserDatasource {
  UserDatasourceImpl(
    this.firebaseAuth,
    this.googleSignInAuth,
    this.googleAuthProvider,
  );

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignInAuth;
  final GoogleAuthProvider googleAuthProvider;

  @override
  Future<UserSignedInEntity> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignInAuth.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      return UserSignedInEntity(
        uid: userCredential.user?.uid ?? '',
        imageUrl: userCredential.user?.photoURL ?? '',
        name: userCredential.user?.displayName ?? '',
        accessToken: await userCredential.user?.getIdToken() ?? '',
        refreshToken: userCredential.user?.refreshToken ?? '',
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw const AuthException(message: ErrorStrings.auth);
    } catch (e) {
      debugPrint(e.toString());
      throw const UnexpectedException(message: ErrorStrings.unexpected);
    }
  }
}
