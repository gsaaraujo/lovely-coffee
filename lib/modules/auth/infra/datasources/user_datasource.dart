import 'package:lovely_coffee/modules/auth/infra/models/user_signed_in_model.dart';

abstract class UserDatasource {
  Future<UserSignedInModel> googleSignIn();

  Future<UserSignedInModel> emailPasswordSignIn(
    String email,
    String password,
  );
}
