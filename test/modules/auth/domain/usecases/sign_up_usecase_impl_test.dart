import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/sign_up_usecase_impl.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository repository;
  late SignUpUsecase usecase;

  const name = 'Gabriel';
  const email = 'gabriel.houth@gmail.com';
  const password = '123';

  setUp(() {
    repository = MockUserRepository();
    usecase = SignUpUsecaseImpl(repository);
  });

  test('usecase should return void', () async {
    when(() => repository.signUp(name, email, password))
        .thenAnswer((_) async => const Right(null));

    final response = await usecase(name, email, password);

    verify(() => repository.signUp(name, email, password));
    expect(response.fold(id, (r) => null), isNull);
  });
}
