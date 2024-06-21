import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/domain/repository/todo/todo_repository.dart';
import 'package:volcano/domain/usecase/todo/todo_use_case.dart';
import 'package:volcano/infrastructure/datasource/todo/todo_data_source.dart';
import 'package:volcano/infrastructure/repository/todo/todo_repository_impl.dart';
import 'package:volcano/presentation/provider/back/global_back_providers.dart';
import 'package:volcano/usecase/todo/todo_use_case_impl.dart';

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final todoClientProvider = Provider<TodoDataSource>(
  (ref) => TodoDataSource(ref.read(networkServiceProvider)),
);

// -----------------------------------------------------------------------------
// Repository
// -----------------------------------------------------------------------------
final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(client: ref.read(todoClientProvider)),
);

// -----------------------------------------------------------------------------
// UseCase
// -----------------------------------------------------------------------------
final todoUseCaseProvider = Provider<TodoUseCase>(
  (ref) => TodoUseCaseImpl(todoRepository: ref.read(todoRepositoryProvider)),
);
