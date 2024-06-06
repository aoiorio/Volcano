import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/repository/auth/auth_repository.dart';
import 'package:volcano/infrastructure/datasource/auth/auth_data_source.dart';
import 'package:volcano/infrastructure/dto/token_dto.dart';
import 'package:volcano/infrastructure/dto/volcano_user_dto.dart';
import 'package:dio/dio.dart';
import 'package:volcano/infrastructure/model/sign_up_volcano_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _client;
  AuthRepositoryImpl({required AuthDataSource client}) : _client = client;

  @override
  Future<Either<AuthError, TokenDTO>> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, String>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, VolcanoUserDTO>> signUp(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    // TODO: implement signUp
    // NOTE I think the data email, password and confirmPassword will be in SignUpVolcanoUserModel.
    try {
      final res = await _client
          .signUp(SignUpVolcanoUserModel(
              email: email,
              password: password,
              confirmPassword: confirmPassword))
          .then((value) {
        return value;
      });
      print(Either.right(res.email));
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      print(res?.statusCode);
      return Either.left(
          AuthError(statusCode: res?.statusCode, message: AuthErrorMessage.fromJson(res?.data)));
    }
  }
}

/*
/ ! error codes are here
await client
        .signUp(SignUpVolcanoUserModel(
            email: email, password: password, confirmPassword: confirmPassword))
        .then((value) {
          return Right(r);
        })
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioException:
          // 失敗した応答のエラーコードとメッセージを取得するサンプル
          // ここでエラーコードのハンドリングると良さげ
          final res = (e as DioException).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage ?? "";
          }
          break;
        default:
      }
      return

*/
