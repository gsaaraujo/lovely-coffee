import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/modules/home/domain/repositories/products_repository.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_products_usecase_impl.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late ProductsRepository repository;
  late GetAllProductsUsecaseImpl usecase;

  const fakeProduct = ProductEntity(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
  );

  setUp(() {
    repository = MockProductsRepository();
    usecase = GetAllProductsUsecaseImpl(repository);
  });

  test('usecase should return a list of ProductEntity', () async {
    when(() => repository.findAllProducts())
        .thenAnswer((_) async => const Right([fakeProduct]));

    final productList = await usecase();

    expect(productList.fold(id, id), isA<List<ProductEntity>>());
  });

  test('usecase should return a BaseFailure', () async {
    when(() => repository.findAllProducts())
        .thenAnswer((_) async => const Left(BaseFailure(message: '')));

    final productList = await usecase();

    expect(productList.fold(id, id), isA<BaseFailure>());
  });
}
