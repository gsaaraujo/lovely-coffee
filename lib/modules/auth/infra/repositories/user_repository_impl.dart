import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/application/constants/error_strings.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';
import 'package:lovely_coffee/modules/auth/infra/datasources/user_datasource.dart';
import 'package:lovely_coffee/modules/auth/infra/faults/failures/auth_failure.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';
import 'package:lovely_coffee/modules/auth/infra/faults/exceptions/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._datasource);

  final UserDatasource _datasource;

  @override
  Future<Either<BaseFailure, UserSignedInEntity>> googleSignIn() async {
    try {
      final UserSignedInModel userSignedIn = await _datasource.googleSignIn();

      return Right(userSignedIn.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return const Left(UnexpectedFailure(message: ErrorStrings.unexpected));
    }
  }
}
