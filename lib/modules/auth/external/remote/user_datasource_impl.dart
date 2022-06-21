import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';

class UserDatasourceImpl implements UserDatasource {
  UserDatasourceImpl(
    this.firebaseAuth,
    this.googleSignIn,
    // this.googleAuthProvider,
  );

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  // final GoogleAuthProvider googleAuthProvider;

  @override
  Future<UserSignedInModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

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
    } on FirebaseAuthException catch (exception, stackTrace) {
      throw AuthException(
        stackTrace: stackTrace,
        errorMessage: exception.message,
      );
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }

  @override
  Future<UserSignedInModel> signInWithCredentials(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserSignedInModel(
        uid: userCredential.user?.uid ?? '',
        imageUrl: userCredential.user?.photoURL ?? '',
        name: userCredential.user?.displayName ?? '',
        accessToken: await userCredential.user?.getIdToken() ?? '',
        refreshToken: userCredential.user?.refreshToken ?? '',
      );
    } on FirebaseAuthException catch (exception, stackTrace) {
      if (exception.code == 'invalid-email') {
        throw InvalidEmailException(
          stackTrace: stackTrace,
          errorMessage: exception.message,
        );
      }

      if (exception.code == 'user-not-found' ||
          exception.code == 'wrong-password') {
        throw InvalidCredentialsException(
          stackTrace: stackTrace,
          errorMessage: exception.message,
        );
      }

      throw UnknownException(
        stackTrace: stackTrace,
        errorMessage: exception.message,
      );
    } catch (exception, stackTrace) {
      throw UnknownException(stackTrace: stackTrace);
    }
  }
}
