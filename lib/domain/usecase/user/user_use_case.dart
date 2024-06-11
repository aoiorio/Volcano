import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';

abstract class UserUseCase {
  Future<Either<BackEndError, VolcanoUser>> executeReadUser(String token);

  Future<Either<BackEndError, VolcanoUser>> executeUpdateUser();
}
