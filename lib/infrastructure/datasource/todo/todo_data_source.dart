import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:volcano/core/config.dart';

import 'package:volcano/infrastructure/dto/todo_dto.dart';

part 'todo_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class TodoDataSource {
  factory TodoDataSource(Dio dio, {String baseUrl}) = _TodoDataSource;

  @GET('/todo/text-to-todo')
  Future<TodoDTO> textToTodo(@Query('voice_text') String voiceText);
}