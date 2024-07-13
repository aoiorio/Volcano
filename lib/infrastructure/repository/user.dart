import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';
import 'package:volcano/domain/repository/user.dart';
import 'package:volcano/infrastructure/datasource/user/user_data_source.dart';
import 'package:volcano/infrastructure/dto/volcano_user.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource client}) : _client = client;
  final UserDataSource _client;

  @override
  Future<Either<BackEndError, VolcanoUserDTO>> readUser(String token) async {
    try {
      final res = await _client.readUser(token);
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
    // return;
  }

  @override
  Future<Either<BackEndError, VolcanoUser>> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
