import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/tyoe_color_object.dart';
import 'package:volcano/presentation/provider/back/type_color_code/providers.dart';

part 'type_color_code_controller.g.dart';

@Riverpod(keepAlive: true)
class TypeColorCodeController extends _$TypeColorCodeController {
  @override
  Either<BackEndError, List<TypeColorObject>> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeReadTypeColorCode() {
    ref
        .read(typeColorCodeUseCaseProvider)
        .executeReadTypeColorCode()
        .then((value) {
      if (value.isRight()) {
        value.getRight().fold(() => null, (typeColorObjectList) {
          state = Either.right(typeColorObjectList);
        });
      } else if (value.isLeft()) {
        value.getLeft().fold(() => null, (error) {
          state = Either.left(error);
          return Either.left(error);
        });
      }
      return value;
    });
  }

  TypeColorObject findTypeFromColorList(String type) {
    final rightState = state.getRight().fold(
          () => <TypeColorObject>[],
          (typeColorObjectList) => typeColorObjectList,
        );

    if (state.isLeft() || rightState.isEmpty) {
      return TypeColorObject();
    }

    final index = rightState
        .indexWhere((typeColorObject) => typeColorObject.type == type);

    // DONE change startColorCode to String value!!! in the entity and dto!!
    if (index == -1) {
      return TypeColorObject();
    }

    return rightState[index];
  }
}
