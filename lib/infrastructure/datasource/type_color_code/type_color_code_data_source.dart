import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// NOTE project imports
import 'package:volcano/core/config.dart';
import 'package:volcano/infrastructure/dto/type_color_code_object.dart';
part 'type_color_code_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class TypeColorCodeDataSource {
  factory TypeColorCodeDataSource(Dio dio, {String baseUrl}) = _TypeColorCodeDataSource;

  @GET('/type-color-code/')
  Future<List<TypeColorObjectDTO>> readTypeColorCode();
}
