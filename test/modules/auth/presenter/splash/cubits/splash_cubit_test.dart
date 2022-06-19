import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_states.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';

class MockCheckIfUserIsAlreadySignedInUsecase extends Mock
    implements CheckIfUserIsAlreadySignedInUsecase {}

void main() {
  late SplashCubit cubit;
  late CheckIfUserIsAlreadySignedInUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockCheckIfUserIsAlreadySignedInUsecase();
    cubit = SplashCubit(mockUsecase);
  });

  group('SplashCubit', () {
    test('SplashCubit should be SplashInitialState', () {
      expect(cubit.state, isA<SplashInitialState>());
    });

    blocTest<SplashCubit, SplashStates>(
      'redirectUser() should emits [SplashLoadingState, SplashRedirectToHomeState]',
      build: () {
        when(() => mockUsecase()).thenAnswer((_) async => true);

        return cubit;
      },
      act: (cubit) => cubit.redirectUser(),
      expect: () => [
        isA<SplashLoadingState>(),
        isA<SplashRedirectToHomeState>(),
      ],
    );

    blocTest<SplashCubit, SplashStates>(
      'redirectUser() should emits [SplashLoadingState, SplashRedirectToSignInState]',
      build: () {
        when(() => mockUsecase()).thenAnswer((_) async => false);

        return cubit;
      },
      act: (cubit) => cubit.redirectUser(),
      expect: () => [
        isA<SplashLoadingState>(),
        isA<SplashRedirectToSignInState>(),
      ],
    );
  });
}
