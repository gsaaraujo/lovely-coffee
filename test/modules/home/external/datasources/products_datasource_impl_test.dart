import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovely_coffee/modules/home/infra/models/product_model.dart';
import 'package:lovely_coffee/modules/home/external/datasources/products_datasource_impl.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirebaseFirestore firestore;
  late ProductsDatasourceImpl datasource;

  setUp(() {
    firestore = MockFirebaseFirestore();
    datasource = ProductsDatasourceImpl(firestore);
  });

  test('findAllProducts should return a list of ProductModel', () async {
    when(() => firestore.collection('products').where('', whereIn: []).get())
        .thenAnswer((_) async => MockQuerySnapshot());

    final productsList = await datasource.findAllProducts();

    expect(productsList, isA<List<ProductModel>>());
  });
}
