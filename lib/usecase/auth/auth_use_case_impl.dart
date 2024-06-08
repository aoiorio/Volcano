// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';
import 'package:volcano/domain/repository/auth/auth_repository.dart';
import 'package:volcano/domain/usecase/auth/auth_use_case.dart';
import 'package:volcano/infrastructure/dto/token_dto.dart';

class AuthUseCaseImpl implements AuthUseCase {
  /*
    - NOTE when I substitute this class,
    I must input AuthRepositoryImpl in provider folder

    - NOTE why I create use case folder is that
    it'll hide my implementation of repository folders
  */

  AuthUseCaseImpl({required AuthRepository authRepository})
      : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  Future<Either<AuthError, TokenDTO>> executeSignIn({
    required String email,
    required String password,
  }) {
    // TODO(new feature): executeSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, TokenDTO>> executeSignOut() {
    // TODO(new feature): executeSignOut
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, Token>> executeSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return _authRepository.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
