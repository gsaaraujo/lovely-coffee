import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/products_repository_impl.dart';

class MockProductsDatasource extends Mock implements ProductsDatasource {}

void main() {
  late ProductsDatasource mockDatasource;
  late ProductsRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockProductsDatasource();
    repository = ProductsRepositoryImpl(mockDatasource);
  });

  const fakeProductEntity = ProductEntity(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
  );

  const fakeProductModel = ProductModel(
    id: '123',
    imageUrl: 'www.productUrl.com',
    name: 'cappuccino',
    additionalInfo: 'with oat milk',
    description: 'very tasty',
    price: 25.50,
  );

  test('findAllProducts should return a list of ProductEntity', () async {
    when(() => mockDatasource.findAllProducts())
        .thenAnswer((_) async => [fakeProductModel]);

    final productList = await repository.findAllProducts();

    expect(productList.fold(id, id), [fakeProductEntity]);
  });

  test('findAllProducts should return a UnexpectedFailure', () async {
    when(() => mockDatasource.findAllProducts())
        .thenThrow(const UnexpectedException(message: ''));

    final productList = await repository.findAllProducts();

    expect(productList.fold(id, id), const UnexpectedFailure(message: ''));
  });
}
