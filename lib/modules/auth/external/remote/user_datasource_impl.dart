import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/app/constants/error_strings.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/infra/faults/exceptions/auth_exception.dart';

class UserDatasourceImpl implements UserDatasource {
  UserDatasourceImpl(
    this.firebaseAuth,
    this.googleSignInAuth,
    this.googleAuthProvider,
  );

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignInAuth;
  final GoogleAuthProvider googleAuthProvider;

  @override
  Future<UserSignedInModel> googleSignIn() async {
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

      return UserSignedInModel(
        uid: userCredential.user?.uid ?? '',
        imageUrl: userCredential.user?.photoURL ?? '',
        name: userCredential.user?.displayName ?? '',
        accessToken: await userCredential.user?.getIdToken() ?? '',
        refreshToken: userCredential.user?.refreshToken ?? '',
      );
    } on FirebaseAuthException catch (e) {
      log(e.message ?? e.code);
      throw const AuthException(message: ErrorStrings.auth);
    } catch (e) {
      log(e.toString());
      throw const UnexpectedException(message: ErrorStrings.unexpected);
    }
  }
}

class _WrapperForGoogleAuthProvider {}
