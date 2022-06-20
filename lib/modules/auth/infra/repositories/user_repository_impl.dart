import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/application/services/device_connectivity/device_connectivity_service.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDatasource, this._connectivityService);

  final UserDatasource _userDatasource;
  final DeviceConnectivityService _connectivityService;

  @override
  Future<Either<BaseException, UserSignedInEntity>> googleSignIn() async {
    try {
      final bool hasNoConnection =
          !(await _connectivityService.hasDeviceConnection());

      if (hasNoConnection) {
        return Left(NoDeviceConnectionException());
      }

      final UserSignedInModel userSignedIn =
          await _userDatasource.googleSignIn();

      return Right(userSignedIn.toEntity());
    } on BaseException catch (exception) {
      return Left(exception);
    }
  }
}
