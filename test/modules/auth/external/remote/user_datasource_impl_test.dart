import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/external/remote/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late UserDatasourceImpl userDatasource;

  const email = 'gabriel.houth@gmail.com';
  const password = '123456';

  const fakeUserSignedInModel = UserSignedInModel(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();

    userDatasource = UserDatasourceImpl(
      mockFirebaseAuth,
      mockGoogleSignIn,
    );
  });

  test('emailPasswordSignIn should return a UserSignedInModel', () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => MockUserCredential());

    final response =
        await userDatasource.signInWithCredentials(email, password);

    expect(response, isA<UserSignedInModel>());
  });

  test('emailPasswordSignIn should throw a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

    final emailPasswordSignIn =
        userDatasource.signInWithCredentials(email, password);

    expect(emailPasswordSignIn, throwsA(isA<InvalidEmailException>()));
  });

  test('emailPasswordSignIn should throw a InvalidCredentialsException',
      () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final emailPasswordSignIn =
        userDatasource.signInWithCredentials(email, password);

    expect(emailPasswordSignIn, throwsA(isA<InvalidCredentialsException>()));
  });

  test('emailPasswordSignIn should throw a UnknownException', () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: ''));

    final emailPasswordSignIn =
        userDatasource.signInWithCredentials(email, password);

    expect(emailPasswordSignIn, throwsA(isA<UnknownException>()));
  });
}
