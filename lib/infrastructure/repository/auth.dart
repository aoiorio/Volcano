import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/repository/auth.dart';
import 'package:volcano/infrastructure/datasource/auth/auth_data_source.dart';
import 'package:volcano/infrastructure/dto/token.dart';
import 'package:volcano/infrastructure/model/auth/sign_in_volcano_user_model.dart';
import 'package:volcano/infrastructure/model/auth/sign_up_volcano_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource client}) : _client = client;
  final AuthDataSource _client;

  @override
  Future<Either<BackEndError, TokenDTO>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client
          .signIn(SignInVolcanoUserModel(email: email, password: password))
          .then((value) {
        debugPrint(value.accessToken);
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, TokenDTO>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // NOTE I think the data email, password and confirmPassword will be in SignUpVolcanoUserModel.
    try {
      final res = await _client
          .signUp(
        SignUpVolcanoUserModel(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      )
          .then((value) {
        return value;
      });
      debugPrint(Either.right(res.accessToken).toString());
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }
}
