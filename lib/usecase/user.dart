// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';
import 'package:volcano/domain/repository/user.dart';
import 'package:volcano/domain/usecase/user.dart';
// import 'package:volcano/domain/usecase/user_use_case.dart';

class UserUseCaseImpl implements UserUseCase {
  UserUseCaseImpl({required UserRepository userRepository})
      : _userRepository = userRepository;
  final UserRepository _userRepository;

  @override
  Future<Either<BackEndError, UserInfo>> executeGetUserInfo(String token) {
    return _userRepository.getUserInfo(token);
  }

  @override
  Future<Either<BackEndError, String>> executeDeleteUser({
    required String token,
  }) {
    return _userRepository.deleteUser(token: token);
  }

  @override
  Future<Either<BackEndError, String>> executeUpdateUser({
    required String token,
    required String email,
    required String username,
    required String icon,
  }) {
    return _userRepository.updateUser(
      token: token,
      email: email,
      username: username,
      icon: icon,
    );
  }
}
