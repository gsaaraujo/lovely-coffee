import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
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

class MockLocalStorage extends Mock implements LocalStorageService {}

class MockSecureLocalStorage extends Mock implements SecureLocalStorageService {
}

class MockBaseException extends BaseException {}

void main() {
  late SignInCubit cubit;
  late LocalStorageService localStorageService;
  late UserGoogleSignInUsecase usecase;
  late SecureLocalStorageService secureLocalStorageService;

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
    usecase = MockUserGoogleSignInUsecase();
    localStorageService = MockLocalStorage();
    secureLocalStorageService = MockSecureLocalStorage();
    cubit =
        SignInCubit(usecase, localStorageService, secureLocalStorageService);
  });

  group('SignInCubit', () {
    test('SignInCubit should be SignInInitialState', () {
      expect(cubit.state, isA<SignInInitialState>());
    });

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn() should emits [SignInLoadingState, SignInSucceedState]',
      build: () {
        when(() => usecase()).thenAnswer(
          (_) async => const Right(fakeUserSignedInEntity),
        );

        when(() => localStorageService.addUser(fakeUserLocalStorage))
            .thenAnswer(
          (_) async => () {},
        );

        when(
          () => secureLocalStorageService.addTokens(fakeUserSecureLocalStorage),
        ).thenAnswer(
          (_) async => () {},
        );

        return cubit;
      },
      act: (cubit) => cubit.googleSignIn(),
      expect: () => [isA<SignInLoadingState>(), isA<SignInSucceedState>()],
    );

    blocTest<SignInCubit, SignInStates>(
      'googleSignIn() should emits [SignInLoadingState, SignInFailedState]',
      build: () {
        when(() => usecase()).thenAnswer(
          (_) async => Left(MockBaseException()),
        );

        when(() => localStorageService.addUser(fakeUserLocalStorage))
            .thenAnswer(
          (_) async => () {},
        );

        when(
          () => secureLocalStorageService.addTokens(fakeUserSecureLocalStorage),
        ).thenAnswer(
          (_) async => () {},
        );

        return cubit;
      },
      act: (cubit) => cubit.googleSignIn(),
      expect: () => [
        isA<SignInLoadingState>(),
        SignInFailedState(message: ExceptionMessagesConst.auth),
      ],
    );
  });
}
