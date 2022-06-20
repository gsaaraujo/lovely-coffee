import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/user_google_sign_in_usecase_impl.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository mockRepository;
  late UserGoogleSignInUsecaseImpl usecase;

  const fakeUserSignedIn = UserSignedInEntity(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = UserGoogleSignInUsecaseImpl(mockRepository);
  });

  test('usecase should return UserSignedInEntity', () async {
    when(() => mockRepository.googleSignIn())
        .thenAnswer((_) async => const Right(fakeUserSignedIn));

    final result = await usecase();

    expect(result.fold(id, id), isA<UserSignedInEntity>());
  });
}
