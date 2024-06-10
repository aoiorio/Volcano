import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/token_dto.dart';

part 'auth_execute_sign_in_controller.g.dart';
@riverpod
class AuthExecuteSignInController extends _$AuthExecuteSignInController {
  @override
  Either<BackEndError, TokenDTO> build() {
    return Either.left(BackEndError());
  }

  void executeSignIn(FToast toast) {

  }
}
