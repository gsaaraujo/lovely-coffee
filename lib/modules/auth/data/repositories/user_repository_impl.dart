import 'package:dartz/dartz.dart';
import 'package:lovely_coffee/app/constants/error_strings.dart';
import 'package:lovely_coffee/core/faults/exceptions/unexpected_exception.dart';
import 'package:lovely_coffee/core/faults/failures/base_failure.dart';
import 'package:lovely_coffee/core/faults/failures/unexpected_failure.dart';
import 'package:lovely_coffee/modules/auth/data/faults/exceptions/auth_exception.dart';
import 'package:lovely_coffee/modules/auth/data/faults/failures/auth_failure.dart';
import 'package:lovely_coffee/modules/auth/domain/repositories/user_repository.dart';
import 'package:lovely_coffee/modules/auth/data/datasources/user_datasource_impl.dart';
import 'package:lovely_coffee/modules/auth/domain/entities/user_signed_up_entity.dart';

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl(this._datasource);

  final IUserDatasource _datasource;

  @override
  Future<Either<BaseFailure, UserSignedInEntity>> googleSignIn() async {
    try {
      final UserSignedInEntity userSignedIn = await _datasource.googleSignIn();

      return Right(userSignedIn);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    } catch (e) {
      return const Left(UnexpectedFailure(message: ErrorStrings.unexpected));
    }
  }
}
