import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';

abstract class UserDatasource {
  Future<UserSignedInModel> signInWithGoogle();

  Future<UserSignedInModel> signInWithCredentials(
    String email,
    String password,
  );

  Future<void> signUp(
    String name,
    String email,
    String password,
  );
}
