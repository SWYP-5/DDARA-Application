import 'package:ddara/domain/usecase/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/provider/repository_provider.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});
