import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/local_storage_exception.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';

class MockLocalStorage extends Mock implements LocalStorageService {}

void main() {
  late MockLocalStorage mockLocalStorage;
  late CheckIfUserIsAlreadySignedInUsecase usecase;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    usecase = CheckIfUserIsAlreadySignedInUsecaseImpl(mockLocalStorage);
  });

  test('usecase should return true when user is already signed in', () async {
    when(() => mockLocalStorage.hasUser())
        .thenAnswer((_) async => const Right(true));

    final hasUser = await usecase();

    verify(() => mockLocalStorage.hasUser());
    expect(hasUser, true);
  });

  test('usecase should return false when user is not already signed in',
      () async {
    when(() => mockLocalStorage.hasUser())
        .thenAnswer((_) async => Left(LocalStorageException()));

    final hasUser = await usecase();

    verify(() => mockLocalStorage.hasUser());
    expect(hasUser, false);
  });
}
