import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';

abstract class AuthUseCase {
  Future<Either<BackEndError, Token>> executeSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<BackEndError, Token>> executeSignIn({
    required String email,
    required String password,
  });
}
