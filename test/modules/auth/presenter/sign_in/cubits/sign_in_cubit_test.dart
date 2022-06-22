import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_states.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_google_usecase_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_credentials_usecase_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';

class MockSignInWithGoogleUsecase extends Mock
    implements SignInWithGoogleUsecase {}

class MockSignInWithCredentialsUsecase extends Mock
    implements SignInWithCredentialsUsecase {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockSecureLocalStorageService extends Mock
    implements SecureLocalStorageService {}

class MockBaseException extends BaseException {}

void main() {
  late SignInCubit cubit;
  late LocalStorageService mockLocalStorageService;
  late SignInWithGoogleUsecase mockSignInWithGoogleUsecase;
  late MockSignInWithCredentialsUsecase mockSignInWithCredentialsUsecase;
  late SecureLocalStorageService mockSecureLocalStorageService;

  const email = 'gabriel.houth@gmail.com';
  const password = '123';

  const fakeUserSignedInEntity = UserSignedInEntity(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  const fakeUserLocalStorage = UserLocalStorageModel(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
  );

  const fakeUserSecureLocalStorage = UserSecureLocalStorageModel(
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockSignInWithGoogleUsecase = MockSignInWithGoogleUsecase();
    mockSignInWithCredentialsUsecase = MockSignInWithCredentialsUsecase();
    mockLocalStorageService = MockLocalStorageService();
    mockSecureLocalStorageService = MockSecureLocalStorageService();

    cubit = SignInCubit(
      mockSignInWithGoogleUsecase,
      mockSignInWithCredentialsUsecase,
      mockLocalStorageService,
      mockSecureLocalStorageService,
    );

    when(() => mockLocalStorageService.addUser(fakeUserLocalStorage))
        .thenAnswer(
      (_) async => () {},
    );

    when(
      () => mockSecureLocalStorageService.addTokens(fakeUserSecureLocalStorage),
    ).thenAnswer(
      (_) async => () {},
    );
  });

  group('SignInCubit', () {
    test('SignInCubit should be SignInInitialState', () {
      expect(cubit.state, isA<SignInInitialState>());
    });

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn should emits [SignInLoadingState, SignInSucceedState]',
      build: () {
        when(() => mockSignInWithGoogleUsecase()).thenAnswer(
          (_) async => const Right(fakeUserSignedInEntity),
        );

        return cubit;
      },
      act: (cubit) {
        cubit.signInWithGoogle();
        verify(() => mockSignInWithGoogleUsecase());
      },
      expect: () => [isA<SignInLoadingState>(), isA<SignInSucceedState>()],
    );

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn should emits [SignInLoadingState, SignInFailedState(auth)]',
      build: () {
        when(() => mockSignInWithGoogleUsecase()).thenAnswer(
          (_) async => Left(AuthException()),
        );

        return cubit;
      },
      act: (cubit) {
        cubit.signInWithGoogle();
        verify(() => mockSignInWithGoogleUsecase());
      },
      expect: () => [
        isA<SignInLoadingState>(),
        SignInFailedState(message: ExceptionMessagesConst.auth),
      ],
    );

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn should emits [SignInLoadingState, SignInFailedState(noConnection)]',
      build: () {
        when(() => mockSignInWithGoogleUsecase()).thenAnswer(
          (_) async => Left(NoDeviceConnectionException()),
        );

        return cubit;
      },
      act: (cubit) {
        cubit.signInWithGoogle();
        verify(() => mockSignInWithGoogleUsecase());
      },
      expect: () => [
        isA<SignInLoadingState>(),
        SignInFailedState(message: ExceptionMessagesConst.noConnection),
      ],
    );

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn should emits [SignInLoadingState, SignInFailedState(unknown)]',
      build: () {
        when(() => mockSignInWithGoogleUsecase()).thenAnswer(
          (_) async => Left(UnknownException()),
        );

        return cubit;
      },
      act: (cubit) {
        cubit.signInWithGoogle();
        verify(() => mockSignInWithGoogleUsecase());
      },
      expect: () => [
        isA<SignInLoadingState>(),
        SignInFailedState(message: ExceptionMessagesConst.unknown),
      ],
    );
  });

  ///////////

  blocTest<SignInCubit, SignInStates>(
    'signInWithCredentials should emits [SignInLoadingState, SignInSucceedState]',
    build: () {
      when(() => mockSignInWithCredentialsUsecase(email, password)).thenAnswer(
        (_) async => const Right(fakeUserSignedInEntity),
      );

      return cubit;
    },
    act: (cubit) {
      cubit.signInWithCredentials(email, password);
      verify(() => mockSignInWithCredentialsUsecase(email, password));
    },
    expect: () => [isA<SignInLoadingState>(), isA<SignInSucceedState>()],
  );

  blocTest<SignInCubit, SignInStates>(
    'signInWithCredentials should emits [SignInLoadingState, SignInFailedState(incorrectCredentials)]',
    build: () {
      when(() => mockSignInWithCredentialsUsecase(email, password)).thenAnswer(
        (_) async => Left(InvalidCredentialsException()),
      );

      return cubit;
    },
    act: (cubit) {
      cubit.signInWithCredentials(email, password);
      verify(() => mockSignInWithCredentialsUsecase(email, password));
    },
    expect: () => [
      isA<SignInLoadingState>(),
      SignInFailedState(message: ExceptionMessagesConst.incorrectCredentials),
    ],
  );

  blocTest<SignInCubit, SignInStates>(
    'signInWithCredentials should emits [SignInLoadingState, SignInFailedState(incorrectCredentials)]',
    build: () {
      when(() => mockSignInWithCredentialsUsecase(email, password)).thenAnswer(
        (_) async => Left(InvalidEmailException()),
      );

      return cubit;
    },
    act: (cubit) {
      cubit.signInWithCredentials(email, password);
      verify(() => mockSignInWithCredentialsUsecase(email, password));
    },
    expect: () => [
      isA<SignInLoadingState>(),
      SignInFailedState(message: ExceptionMessagesConst.invalidEmail),
    ],
  );

  blocTest<SignInCubit, SignInStates>(
    'signInWithCredentials should emits [SignInLoadingState, SignInFailedState(noConnection)]',
    build: () {
      when(() => mockSignInWithCredentialsUsecase(email, password)).thenAnswer(
        (_) async => Left(NoDeviceConnectionException()),
      );

      return cubit;
    },
    act: (cubit) {
      cubit.signInWithCredentials(email, password);
      verify(() => mockSignInWithCredentialsUsecase(email, password));
    },
    expect: () => [
      isA<SignInLoadingState>(),
      SignInFailedState(message: ExceptionMessagesConst.noConnection),
    ],
  );

  blocTest<SignInCubit, SignInStates>(
    'signInWithCredentials should emits [SignInLoadingState, SignInFailedState(unknown)]',
    build: () {
      when(() => mockSignInWithCredentialsUsecase(email, password)).thenAnswer(
        (_) async => Left(UnknownException()),
      );

      return cubit;
    },
    act: (cubit) {
      cubit.signInWithCredentials(email, password);
      verify(() => mockSignInWithCredentialsUsecase(email, password));
    },
    expect: () => [
      isA<SignInLoadingState>(),
      SignInFailedState(message: ExceptionMessagesConst.unknown),
    ],
  );
}
