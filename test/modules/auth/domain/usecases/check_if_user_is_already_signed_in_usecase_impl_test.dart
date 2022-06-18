import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage.dart';
import 'package:lovely_coffee/modules/auth/domain/usecases/check_if_user_is_already_signed_in_usecase_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockLocalStorage mockLocalStorage;
  late CheckIfUserIsAlreadySignedInUsecaseImpl usecase;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    usecase = CheckIfUserIsAlreadySignedInUsecaseImpl(mockLocalStorage);
  });

  test('usecase should return true', () async {
    when(() => mockLocalStorage.hasUser()).thenAnswer((_) async => true);

    final hasUser = await usecase();

    expect(hasUser, true);
  });

  test('usecase should return false', () async {
    when(() => mockLocalStorage.hasUser()).thenAnswer((_) async => false);

    final hasUser = await usecase();

    expect(hasUser, false);
  });
}
