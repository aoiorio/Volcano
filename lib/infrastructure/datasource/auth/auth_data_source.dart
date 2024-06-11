import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:volcano/core/config.dart';
// NOTE project imports
import 'package:volcano/infrastructure/dto/token_dto.dart';
import 'package:volcano/infrastructure/model/sign_in_volcano_user_model.dart';
import 'package:volcano/infrastructure/model/sign_up_volcano_user_model.dart';

part 'auth_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  // TODOchange the value to correct one.
  @POST('/auth/sign_up_user')
  Future<TokenDTO> signUp(
    @Body() SignUpVolcanoUserModel signUpVolcanoUserModel,
  );

  // NOTE signIn method will return Token
  @POST('/auth/sign_in_user')
  Future<TokenDTO> signIn(
    @Body() SignInVolcanoUserModel signInVolcanoUserModel,
  );

  @GET('auth/sign_out_user')
  Future<String> signOut();
}
