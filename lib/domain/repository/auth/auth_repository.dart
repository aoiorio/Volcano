import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';
// import 'package:fpdart/fpdart.dart' as fp;


// NOTE if the values that return from back-end, they must be an entity.
abstract class AuthRepository {
  Future<Either<AuthError, Token>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<AuthError, Token>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AuthError, String>> signOut();
}
