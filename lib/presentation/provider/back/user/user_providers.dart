import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTE project imports
import 'package:volcano/domain/repository/auth/auth_repository.dart';
import 'package:volcano/domain/repository/user/user_repository.dart';
import 'package:volcano/domain/usecase/auth/auth_use_case.dart';
import 'package:volcano/domain/usecase/user/user_use_case.dart';
import 'package:volcano/infrastructure/datasource/user/user_data_source.dart';
import 'package:volcano/infrastructure/repository/auth/auth_repository_impl.dart';
import 'package:volcano/infrastructure/repository/user/user_repository_impl.dart';
import 'package:volcano/presentation/provider/back/global_back_providers.dart';
import 'package:volcano/usecase/auth/auth_use_case_impl.dart';
import 'package:volcano/usecase/user/user_use_case_impl.dart';

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final userClientProvider = Provider<UserDataSource>(
  (ref) => UserDataSource(ref.read(networkServiceProvider)),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(client: ref.read(userClientProvider)),
);

// -----------------------------------------------------------------------------
// UseCase
// -----------------------------------------------------------------------------
final userUseCaseProvider = Provider<UserUseCase>(
  (ref) => UserUseCaseImpl(userRepository: ref.read(userRepositoryProvider)),
);
