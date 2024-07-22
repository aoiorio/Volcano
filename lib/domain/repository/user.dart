import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';

abstract class UserRepository {
  Future<Either<BackEndError, UserInfo>> getUserInfo(String token);

  Future<Either<BackEndError, String>> updateUser({
    required String token,
    required String email,
    required String username,
    required String icon,
  });

  Future<Either<BackEndError, String>> deleteUser({required String token});
}
