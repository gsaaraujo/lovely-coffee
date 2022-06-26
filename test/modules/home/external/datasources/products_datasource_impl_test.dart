import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/infra/datasources/products_datasource.dart';
import 'package:lovely_coffee/modules/home/external/datasources/products_datasource_impl.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseFirestore firestore;
  late ProductsDatasource datasource;

  const Map<String, dynamic> data = {
    "id": '123',
    "imageUrl": 'www.imageUrl.com.br',
    "name": 'cappuccino',
    "additionalInfo": 'milk',
    "description": 'none',
    "price": 12.20,
  };

  const product = ProductModel(
    id: '123',
    imageUrl: 'www.imageUrl.com.br',
    name: 'cappuccino',
    additionalInfo: 'milk',
    description: 'none',
    price: 1220,
  );

  setUp(() {
    firestore = MockFirebaseFirestore();
    datasource = ProductsDatasourceImpl(firestore);
  });

  test('findAllProducts should return a list of ProductModel', () async {
    final instance = FakeFirebaseFirestore();

    await instance.collection('products').doc().set(data);
    final querySnapshot = instance.collection('products');

    when(() => firestore.collection('products'))
        .thenAnswer((_) => querySnapshot);

    final productsList = await datasource.findAllProducts();

    verify(() => firestore.collection('products'));
    expect(productsList, [product]);
  });

  test('findAllProducts should throw a UnknownException', () async {
    when(() => firestore.collection('products')).thenThrow(Exception());

    final productsList = datasource.findAllProducts();

    verify(() => firestore.collection('products'));
    expect(productsList, throwsA(isA<UnknownException>()));
  });
}
