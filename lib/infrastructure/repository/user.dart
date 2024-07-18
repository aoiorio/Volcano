import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';
import 'package:volcano/domain/repository/user.dart';
import 'package:volcano/infrastructure/datasource/user/user_data_source.dart';
import 'package:volcano/infrastructure/dto/user_info.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource client}) : _client = client;
  final UserDataSource _client;

  @override
  Future<Either<BackEndError, UserInfoDTO>> getUserInfo(String token) async {
    try {
      final res = await _client.getUserInfo(token);
      debugPrint(res.email);
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.toString());
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
  Future<Either<BackEndError, VolcanoUser>> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<BackEndError, String>> deleteUser({
    required String token,
  }) async {
    try {
      await _client.deleteUser(token);
      return Either.right('Deleted');
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.toString());
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
