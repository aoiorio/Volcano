import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/repository/type_color_code.dart';
import 'package:volcano/infrastructure/datasource/type_color_code/type_color_code_data_source.dart';
import 'package:volcano/infrastructure/dto/type_color_code_object.dart';

// ignore: one_member_abstracts
class TypeColorCodeRepositoryImpl implements TypeColorCodeRepository {
  TypeColorCodeRepositoryImpl({required TypeColorCodeDataSource client})
      : _client = client;
  final TypeColorCodeDataSource _client;

  @override
  Future<Either<BackEndError, List<TypeColorObjectDTO>>>
      readTypeColorCode() async {
    try {
      final res = await _client.readTypeColorCode().then((value) {
        if (value[0].type != null) {
          debugPrint(value[0].type);
        }
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
}
