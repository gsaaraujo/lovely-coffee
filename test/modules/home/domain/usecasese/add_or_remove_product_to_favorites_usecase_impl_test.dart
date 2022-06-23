import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/favorite_products_repository.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/add_or_remove_product_to_favorites_usecase_impl.dart';

class MockFavoriteProductsRepository extends Mock
    implements FavoriteProductsRepository {}

class MockBaseException extends Mock implements BaseException {}

void main() {
  late AddOrRemoveProductToFavoritesUsecase usecase;
  late FavoriteProductsRepository repository;

  const productId = '123';
  const userId = '777';

  setUp(() {
    repository = MockFavoriteProductsRepository();
    usecase = AddOrRemoveProductToFavoritesUsecaseImpl(repository);
  });

  test('usecase should return void while add/remove a product to favorites',
      () async {
    when(() => repository.addOrRemoveProductToFavorites(productId, userId))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(productId, userId);

    verify(() => usecase(productId, userId));
    expect(result.fold(id, (r) => null), isNull);
  });

  test('usecase should return BaseException', () async {
    when(() => repository.addOrRemoveProductToFavorites(productId, userId))
        .thenAnswer((_) async => Left(MockBaseException()));

    final result = await usecase(productId, userId);

    verify(() => usecase(productId, userId));
    expect(result.fold(id, (r) => null), isA<MockBaseException>());
  });
}
