import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTE project imports
import 'package:volcano/domain/repository/auth.dart';
import 'package:volcano/domain/usecase/auth.dart';
import 'package:volcano/infrastructure/datasource/auth/auth_data_source.dart';
import 'package:volcano/infrastructure/repository/auth.dart';
import 'package:volcano/presentation/provider/back/global_back_providers.dart';
import 'package:volcano/usecase/auth.dart';

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final authClientProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(networkServiceProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(client: ref.read(authClientProvider)),
);

// -----------------------------------------------------------------------------
// UseCase
// -----------------------------------------------------------------------------
final authUseCaseProvider = Provider<AuthUseCase>(
  (ref) => AuthUseCaseImpl(authRepository: ref.read(authRepositoryProvider)),
);
