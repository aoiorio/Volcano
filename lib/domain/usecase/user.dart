import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';

abstract class UserUseCase {
  Future<Either<BackEndError, UserInfo>> executeGetUserInfo(String token);

  Future<Either<BackEndError, String>> executeUpdateUser({
    required String token,
    required String email,
    required String username,
    required String icon,
  });

  Future<Either<BackEndError, String>> executeDeleteUser({
    required String token,
  });
}
