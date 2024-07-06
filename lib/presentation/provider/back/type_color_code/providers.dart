import 'package:flutter_riverpod/flutter_riverpod.dart';

// NOTE project imports
import 'package:volcano/domain/repository/type_color_code.dart';
import 'package:volcano/domain/usecase/type_color_code.dart';
import 'package:volcano/infrastructure/datasource/type_color_code/type_color_code_data_source.dart';
import 'package:volcano/infrastructure/repository/type_color_code.dart';
import 'package:volcano/presentation/provider/back/global_back_providers.dart';
import 'package:volcano/usecase/type_color_code.dart';

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final typeColorCodeClientProvider = Provider<TypeColorCodeDataSource>(
  (ref) => TypeColorCodeDataSource(ref.read(networkServiceProvider)),
);

final typeColorCodeRepositoryProvider = Provider<TypeColorCodeRepository>(
  (ref) => TypeColorCodeRepositoryImpl(client: ref.read(typeColorCodeClientProvider)),
);

// -----------------------------------------------------------------------------
// UseCase
// -----------------------------------------------------------------------------
final typeColorCodeUseCaseProvider = Provider<TypeColorCodeUseCase>(
  (ref) => TypeColorCodeUseCaseImpl(typeColorCodeRepository: ref.read(typeColorCodeRepositoryProvider)),
);
