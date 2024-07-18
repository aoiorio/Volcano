import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/user_info.dart';
import 'package:volcano/domain/entity/volcano_user.dart';

abstract class UserUseCase {
  Future<Either<BackEndError, UserInfo>> executeGetUserInfo(String token);

  Future<Either<BackEndError, VolcanoUser>> executeUpdateUser();

  Future<Either<BackEndError, String>> executeDeleteUser({required String token});
}
