import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/tyoe_color_object.dart';

// ignore: one_member_abstracts
abstract class TypeColorCodeUseCase {
  Future<Either<BackEndError, List<TypeColorObject>>>
      executeReadTypeColorCode();
}
