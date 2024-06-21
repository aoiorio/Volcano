import 'package:dio/dio.dart';
// import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:volcano/core/config.dart';
// NOTE project imports
import 'package:volcano/infrastructure/dto/volcano_user_dto.dart';

part 'user_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  // TODOchange the value to correct one.
  @GET('/user')
  Future<VolcanoUserDTO> readUser(@Query('token') String token);
}
