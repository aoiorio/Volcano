import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';

abstract class UserRepository {
  Future<Either<BackEndError, VolcanoUser>> readUser(String token);

  Future<Either<BackEndError, VolcanoUser>> updateUser();
}
