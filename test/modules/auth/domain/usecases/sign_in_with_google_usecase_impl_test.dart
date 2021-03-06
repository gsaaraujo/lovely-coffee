import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_google_usecase_impl.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockBaseException extends BaseException {}

void main() {
  late UserRepository mockRepository;
  late SignInWithGoogleUsecase usecase;

  const fakeUserSignedIn = UserSignedInEntity(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = SignInWithGoogleUsecaseImpl(mockRepository);
  });

  test('usecase should return a UserSignedInEntity', () async {
    when(() => mockRepository.signInWithGoogle())
        .thenAnswer((_) async => const Right(fakeUserSignedIn));

    final result = await usecase();

    verify(() => mockRepository.signInWithGoogle());
    expect(result.fold(id, id), fakeUserSignedIn);
  });

  test('usecase should return a BaseException', () async {
    when(() => mockRepository.signInWithGoogle())
        .thenAnswer((_) async => Left(MockBaseException()));

    final result = await usecase();

    verify(() => mockRepository.signInWithGoogle());
    expect(result.fold(id, id), MockBaseException());
  });
}
