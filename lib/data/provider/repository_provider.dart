import 'package:ddara/core/auth/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/auth_repository.dart';
import '../repository/auth_repository_impl.dart';
import 'datasource_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(kakaoAuthProvider),
    ref.read(googleAuthProvider),
  );
});
