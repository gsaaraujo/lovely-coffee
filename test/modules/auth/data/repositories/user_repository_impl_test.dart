import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:lovely_coffee/modules/auth/data/faults/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/data/faults/failures/auth_failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/data/datasources/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/data/repositories/user_repository_impl.dart';

class MockUserDatasource extends Mock implements IUserDatasource {}

void main() {
  late IUserDatasource mockDatasource;
  late UserRepositoryImpl repository;

  const fakeUserSignedIn = UserSignedInEntity(
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

  test('googleSignIn should return fakeUserSignedIn', () async {
    when(() => mockDatasource.googleSignIn())
        .thenAnswer((_) async => fakeUserSignedIn);

    final response = await repository.googleSignIn();

    expect(response.fold(id, id), fakeUserSignedIn);
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
