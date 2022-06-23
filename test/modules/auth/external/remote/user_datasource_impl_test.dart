import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as mocks;
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/external/remote/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/email_already_in_use_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/password_is_too_weak_exception.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late UserDatasourceImpl userDatasource;

  const name = 'Gabriel';
  const uid = 'abc-123';
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

  test('signInWithCredentials should return a UserSignedInModel', () async {
    // Mocks
    final user = mocks.MockUser(
      isAnonymous: false,
      uid: uid,
      email: email,
      displayName: name,
    );

    final auth = mocks.MockFirebaseAuth(mockUser: user);

    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Test

    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => userCredential);

    final response =
        await userDatasource.signInWithCredentials(email, password);

    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(response, fakeUserSignedInModel);
  });

  test('signInWithCredentials should throw a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

    final signInWithCredentials =
        userDatasource.signInWithCredentials(email, password);

    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signInWithCredentials, throwsA(isA<InvalidEmailException>()));
  });

  test('signInWithCredentials should throw a InvalidCredentialsException',
      () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final signInWithCredentials =
        userDatasource.signInWithCredentials(email, password);

    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signInWithCredentials, throwsA(isA<InvalidCredentialsException>()));
  });

  test('signInWithCredentials should throw a UnknownException', () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: ''));

    final signInWithCredentials =
        userDatasource.signInWithCredentials(email, password);

    verify(
      () => mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signInWithCredentials, throwsA(isA<UnknownException>()));
  });

  //////////

  test('signUp should return a void when success', () async {
    // Mocks

    final user = mocks.MockUser(
      uid: '',
      email: email,
    );

    final auth = mocks.MockFirebaseAuth(mockUser: user);

    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Test
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => userCredential);

    await userDatasource.signUp(name, email, password);

    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  });

  test('signUp should throws a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

    final signUp = userDatasource.signUp(name, email, password);

    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signUp, throwsA(isA<InvalidEmailException>()));
  });

  test('signUp should throws a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

    final signUp = userDatasource.signUp(name, email, password);

    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signUp, throwsA(isA<EmailAlreadyInUseException>()));
  });

  test('signUp should throws a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(FirebaseAuthException(code: 'weak-password'));

    final signUp = userDatasource.signUp(name, email, password);

    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signUp, throwsA(isA<PasswordIsTooWeakException>()));
  });

  test('signUp should throws a InvalidEmailException', () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(Exception());

    final signUp = userDatasource.signUp(name, email, password);

    verify(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    expect(signUp, throwsA(isA<UnknownException>()));
  });
}
