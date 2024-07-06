// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/tyoe_color_object.dart';
import 'package:volcano/domain/repository/type_color_code.dart';
import 'package:volcano/domain/usecase/type_color_code.dart';

class TypeColorCodeUseCaseImpl implements TypeColorCodeUseCase {
  TypeColorCodeUseCaseImpl({
    required TypeColorCodeRepository typeColorCodeRepository,
  }) : _typeColorCodeRepository = typeColorCodeRepository;
  final TypeColorCodeRepository _typeColorCodeRepository;

  @override
  Future<Either<BackEndError, List<TypeColorObject>>>
      executeReadTypeColorCode() {
    final typeColorCode = _typeColorCodeRepository.readTypeColorCode();
    return typeColorCode;
  }
}
