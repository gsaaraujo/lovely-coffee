import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_in_entity.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_in_with_credentials_usecase_impl.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockBaseException extends BaseException {}

void main() {
  late MockUserRepository mockRepository;
  late SignInWithCredentialsUsecase usecase;

  const email = 'gabriel.houth@gmail.com';
  const password = '123456';

  const fakeUserSignedInEntity = UserSignedInEntity(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = SignInWithCredentialsUsecaseImpl(mockRepository);
  });

  test('usecase should return a UserSignedInEntity', () async {
    when(() => mockRepository.signInWithCredentials(email, password))
        .thenAnswer((_) async => const Right(fakeUserSignedInEntity));

    final response = await usecase(email, password);

    verify(() => mockRepository.signInWithCredentials(email, password));
    expect(response.fold(id, id), fakeUserSignedInEntity);
  });

  test('usecase should return a BaseException', () async {
    when(() => mockRepository.signInWithCredentials(email, password))
        .thenAnswer((_) async => Left(MockBaseException()));

    final response = await usecase(email, password);

    verify(() => mockRepository.signInWithCredentials(email, password));
    expect(response.fold(id, id), MockBaseException());
  });
}
