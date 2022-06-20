import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/infra/repositories/user_repository_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_email_exception.dart';
import 'package:lovely_coffee/modules/auth/domain/exceptions/invalid_credentials_exception.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class MockUserDatasource extends Mock implements UserDatasource {}

class MockBaseException extends BaseException {}

class MockDeviceConnectivityService extends Mock
    implements DeviceConnectivityService {}

void main() {
  late UserRepositoryImpl repository;
  late UserDatasource mockDatasource;
  late DeviceConnectivityService mockDeviceConnectivityService;

  const email = 'gabriel.houth@gmail.com';
  const password = '123456';

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
    mockDeviceConnectivityService = MockDeviceConnectivityService();
    repository = UserRepositoryImpl(
      mockDatasource,
      mockDeviceConnectivityService,
    );
  });

  test('googleSignIn should return fakeUserSignedInEntity', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.googleSignIn())
        .thenAnswer((_) async => fakeUserSignedInModel);

    final userSignedIn = await repository.googleSignIn();

    expect(userSignedIn.fold(id, id), fakeUserSignedInEntity);
  });

  test('googleSignIn should return NoDeviceConnectionException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => false);

    final userSignedIn = await repository.googleSignIn();

    expect(userSignedIn.fold(id, id), NoDeviceConnectionException());
  });

  test('googleSignIn should return AuthException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.googleSignIn()).thenThrow(AuthException());

    final userSignedIn = await repository.googleSignIn();

    expect(userSignedIn.fold(id, id), AuthException());
  });

  test('googleSignIn should return UnknownException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.googleSignIn()).thenThrow(UnknownException());

    final userSignedIn = await repository.googleSignIn();

    expect(userSignedIn.fold(id, id), UnknownException());
  });

  ///

  test('emailPasswordSignIn should return NoDeviceConnectionException',
      () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => false);

    final userSignedIn = await repository.emailPasswordSignIn(email, password);

    expect(userSignedIn.fold(id, id), NoDeviceConnectionException());
  });

  test('emailPasswordSignIn should return InvalidEmailException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.emailPasswordSignIn(email, password))
        .thenThrow(InvalidEmailException());

    final userSignedIn = await repository.emailPasswordSignIn(email, password);

    expect(userSignedIn.fold(id, id), InvalidEmailException());
  });

  test('emailPasswordSignIn should return InvalidCredentialsException',
      () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.emailPasswordSignIn(email, password))
        .thenThrow(InvalidCredentialsException());

    final userSignedIn = await repository.emailPasswordSignIn(email, password);

    expect(userSignedIn.fold(id, id), InvalidCredentialsException());
  });

  test('emailPasswordSignIn should return UnknownException', () async {
    when(() => mockDeviceConnectivityService.hasDeviceConnection())
        .thenAnswer((_) async => true);

    when(() => mockDatasource.emailPasswordSignIn(email, password))
        .thenThrow(UnknownException());

    final userSignedIn = await repository.emailPasswordSignIn(email, password);

    expect(userSignedIn.fold(id, id), UnknownException());
  });
}
