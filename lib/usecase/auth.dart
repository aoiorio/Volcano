// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';
import 'package:volcano/domain/repository/auth.dart';
import 'package:volcano/domain/usecase/auth.dart';

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
  Future<Either<BackEndError, Token>> executeSignIn({
    required String email,
    required String password,
  }) {
    // NOTE it will return access_token
    return _authRepository.signIn(email: email, password: password);
  }

  @override
  Future<Either<BackEndError, Token>> executeSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _authRepository.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
