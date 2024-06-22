// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';
import 'package:volcano/domain/repository/user.dart';
import 'package:volcano/domain/usecase/user.dart';
// import 'package:volcano/domain/usecase/user_use_case.dart';

class UserUseCaseImpl implements UserUseCase {
  UserUseCaseImpl({required UserRepository userRepository})
      : _userRepository = userRepository;
  final UserRepository _userRepository;

  @override
  Future<Either<BackEndError, VolcanoUser>> executeReadUser(String token) {
    return _userRepository.readUser(token);
  }

  @override
  Future<Either<BackEndError, VolcanoUser>> executeUpdateUser() {
    // TODO: implement executeUpdateUser
    throw UnimplementedError();
  }
}
