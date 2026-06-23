import 'package:ddara/core/local/provider/local_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_provider.dart';
import '../datasource/auth/auth_datasource.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    ref.read(dioProvider),
    ref.read(secureStorageProvider),
  );
});
