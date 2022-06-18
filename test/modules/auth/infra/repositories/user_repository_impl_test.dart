import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/modules/auth/infra/faults/failures/auth_failure.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/infra/faults/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/repositories/user_repository_impl.dart';

class MockUserDatasource extends Mock implements UserDatasource {}

void main() {
  late UserDatasource mockDatasource;
  late UserRepositoryImpl repository;

  const fakeUserSignedInModel = UserSignedInModel(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  const fakeUserSignedInEntity = UserSignedInEntity(
    uid: 'abc-123',
    imageUrl: 'www.imageUrl.com',
    name: 'Gabriel',
    accessToken: 'fsedf234432km4k3l2mn',
    refreshToken: 'klopklopkpjkef903sdfsd',
  );

  setUp(() {
    mockDatasource = MockUserDatasource();
    repository = UserRepositoryImpl(mockDatasource);
  });

  test('googleSignIn should return fakeUserSignedInEntity', () async {
    when(() => mockDatasource.googleSignIn())
        .thenAnswer((_) async => fakeUserSignedInModel);

    final response = await repository.googleSignIn();

    expect(response.fold(id, id), fakeUserSignedInEntity);
  });

  test('googleSignIn should throw AuthFailure', () async {
    when(() => mockDatasource.googleSignIn())
        .thenThrow(const AuthException(message: ''));

    final response = await repository.googleSignIn();

    expect(response.fold(id, id), const AuthFailure(message: ''));
  });

  test('googleSignIn should throw UnexpectedFailure', () async {
    when(() => mockDatasource.googleSignIn())
        .thenThrow(const UnexpectedException(message: ''));

    final response = await repository.googleSignIn();

    expect(response.fold(id, id), const UnexpectedFailure(message: ''));
  });
}
