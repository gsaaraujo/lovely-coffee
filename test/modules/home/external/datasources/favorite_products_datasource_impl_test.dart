import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lovely_coffee/modules/home/external/datasources/favorite_products_datasource_impl.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseFirestore mockFirestore;
  late FavoriteProductsDatasourceImpl datasource;

  const productId = '123';
  const userId = '777';

  const Map<String, dynamic> data = {
    "productId": productId,
    "userId": userId,
  };

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    datasource = FavoriteProductsDatasourceImpl(mockFirestore);
  });

  test(
      'addOrRemoveProductToFavorites should add data when its not already in there',
      () async {
    // Mocks

    final instance = FakeFirebaseFirestore();

    await instance.collection('favorite-products').add({
      "productId": '000',
      "userId": '999',
    });

    final collectionReference = instance.collection('favorite-products');

    // Tests

    when(() => mockFirestore.collection('favorite-products'))
        .thenAnswer((_) => collectionReference);

    await datasource.addOrRemoveProductToFavorites(productId, userId);

    verify(() => mockFirestore.collection('favorite-products')).called(2);
  });
}
