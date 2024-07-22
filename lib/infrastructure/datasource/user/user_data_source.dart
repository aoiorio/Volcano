import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:volcano/core/config.dart';
// NOTE project imports
import 'package:volcano/infrastructure/dto/user_info.dart';
import 'package:volcano/infrastructure/model/user/update_user_model.dart';

part 'user_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  // TODOchange the value to correct one.
  @GET('/user/')
  Future<UserInfoDTO> getUserInfo(@Query('token') String token);

  @DELETE('/user/')
  Future<HttpResponse<void>> deleteUser(@Query('token') String token);

  @PUT('/user/')
  Future<HttpResponse<void>> updateUser(
    @Query('token') String token,
    @Body() UpdateUserModel updateUserModel,
  );
}
