import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_email_password_sign_in_usecase_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_states.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';

class MockUserGoogleSignInUsecase extends Mock
    implements UserGoogleSignInUsecase {}

class MockUserEmailPasswordSignInUsecase extends Mock
    implements UserEmailPasswordSignInUsecase {}

class MockLocalStorage extends Mock implements LocalStorageService {}

class MockSecureLocalStorage extends Mock implements SecureLocalStorageService {
}

class MockBaseException extends BaseException {}

void main() {
  late SignInCubit cubit;
  late LocalStorageService mockLocalStorageService;
  late UserGoogleSignInUsecase mockGoogleSignInUsecase;
  late MockUserEmailPasswordSignInUsecase mockEmailPasswordSignInUsecase;
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
    mockGoogleSignInUsecase = MockUserGoogleSignInUsecase();
    mockEmailPasswordSignInUsecase = MockUserEmailPasswordSignInUsecase();
    mockLocalStorageService = MockLocalStorage();
    mockSecureLocalStorageService = MockSecureLocalStorage();

    cubit = SignInCubit(
      mockGoogleSignInUsecase,
      mockEmailPasswordSignInUsecase,
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
      'googleSignIn() should emits [SignInLoadingState, SignInSucceedState]',
      build: () {
        when(() => mockGoogleSignInUsecase()).thenAnswer(
          (_) async => const Right(fakeUserSignedInEntity),
        );

        return cubit;
      },
      act: (cubit) => cubit.googleSignIn(),
      expect: () => [isA<SignInLoadingState>(), isA<SignInSucceedState>()],
    );

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn() should emits [SignInLoadingState, SignInFailedState]',
      build: () {
        when(() => mockGoogleSignInUsecase()).thenAnswer(
          (_) async => Left(MockBaseException()),
        );

        return cubit;
      },
      act: (cubit) => cubit.googleSignIn(),
      expect: () => [
        isA<SignInLoadingState>(),
        SignInFailedState(message: ExceptionMessagesConst.auth),
      ],
    );

    blocTest<SignInCubit, SignInStates>(
      'emailPasswordSignIn() should emits [SignInLoadingState, SignInSucceedState]',
      build: () {
        when(() => mockEmailPasswordSignInUsecase(email, password)).thenAnswer(
          (_) async => const Right(fakeUserSignedInEntity),
        );

        return cubit;
      },
      act: (cubit) => cubit.emailPasswordSignIn(email, password),
      expect: () => [isA<SignInLoadingState>(), isA<SignInSucceedState>()],
    );
  });
}
