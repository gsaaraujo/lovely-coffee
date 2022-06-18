import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/application/models/user_secure_local_storage_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage.dart';
import 'package:lovely_coffee/modules/auth/presenter/cubits/sign_in_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/cubits/sign_in_states.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';

class MockUserGoogleSignInUsecase extends Mock
    implements UserGoogleSignInUsecase {}

class MockLocalStorage extends Mock implements LocalStorage {}

class MockSecureLocalStorage extends Mock implements SecureLocalStorage {}

void main() {
  late SignInCubit cubit;
  late LocalStorage localStorage;
  late UserGoogleSignInUsecase usecase;
  late SecureLocalStorage secureLocalStorage;

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
    localStorage = MockLocalStorage();
    secureLocalStorage = MockSecureLocalStorage();
    cubit = SignInCubit(usecase, localStorage, secureLocalStorage);
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

        when(() => localStorage.addUser(fakeUserLocalStorage)).thenAnswer(
          (_) async => () {},
        );

        when(
          () => secureLocalStorage.addTokens(fakeUserSecureLocalStorage),
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
          (_) async => const Left(BaseFailure(message: '')),
        );

        when(() => localStorage.addUser(fakeUserLocalStorage)).thenAnswer(
          (_) async => () {},
        );

        when(
          () => secureLocalStorage.addTokens(fakeUserSecureLocalStorage),
        ).thenAnswer(
          (_) async => () {},
        );

        return cubit;
      },
      act: (cubit) => cubit.googleSignIn(),
      expect: () => [isA<SignInLoadingState>(), SignInFailedState(message: '')],
    );
  });
}
