import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';
import 'package:volcano/domain/entity/volcano_user.dart';

abstract class UserRepository {
  Future<Either<BackEndError, UserInfo>> getUserInfo(String token);

  Future<Either<BackEndError, VolcanoUser>> updateUser();

  Future<Either<BackEndError, String>> deleteUser({required String token});
}
