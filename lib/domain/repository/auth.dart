import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';

// NOTE if the values that return from back-end, they must be an entity.
abstract class AuthRepository {
  Future<Either<BackEndError, Token>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<BackEndError, Token>> signIn({
    required String email,
    required String password,
  });
}
