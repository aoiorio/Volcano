import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:volcano/core/config.dart';
import 'package:volcano/infrastructure/dto/goal_percentage.dart';
import 'package:volcano/infrastructure/dto/read_todo.dart';

import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/infrastructure/model/todo/post_todo_model.dart';
import 'package:volcano/infrastructure/model/todo/update_todo_model.dart';

part 'todo_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class TodoDataSource {
  factory TodoDataSource(Dio dio, {String baseUrl}) = _TodoDataSource;

  @GET('/todo/text-to-todo')
  Future<TodoDTO> textToTodo(@Query('voice_text') String voiceText);

  @POST('/todo/')
  @MultiPart()
  Future<TodoDTO> postTodo(
    @Query('token') String token,
    @Query('title') String title,
    @Query('description') String? description,
    @Query('period') DateTime period,
    @Query('type') String type,
    @Query('priority') int priority,
    @Part(name: 'audio') File audio,
  );

  @POST('/todo/post-todo-from-text')
  Future<TodoDTO> postTodoFromText(
    @Query('token') String token,
    @Body() PostTodoModel postTodoModel,
  );

  @GET('/todo/user-todo/')
  Future<List<ReadTodoDTO>> readTodo(
    @Query('token') String token,
  );

  @PUT('/todo/')
  Future<HttpResponse<void>> updateTodo(
    @Query('todo_id') String todoId,
    @Body() UpdateTodoModel updateTodoModel,
  );

  @GET('/todo/user-goals/')
  Future<GoalPercentageDTO> getGoalPercentage(
    @Query('token') String token,
  );
}
