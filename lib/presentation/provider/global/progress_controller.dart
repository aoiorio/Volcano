import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';

part 'progress_controller.g.dart';

@riverpod
class ProgressController extends _$ProgressController {
  @override
  bool build() => false;

  Future<Either<AuthError, Token>> executeWithProgress(
    Future<Either<AuthError, Token>> f,
  ) async {
    try {
      state = true; // status to true
      return await f;
    } finally {
      state = false; // status to false
    }
  }
}
