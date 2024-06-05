import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';
import 'package:volcano/domain/entity/volcano_user.dart';

abstract class AuthUseCase {
  Future<Either<AuthError, VolcanoUser>> executeSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<AuthError, Token>> executeSignIn({
    required String email,
    required String password,
  });

  Future<Either<AuthError, String>> executeSignOut();
}
