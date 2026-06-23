import 'package:ddara/core/auth/provider/auth_provider.dart';
import 'package:ddara/domain/usecase/login_use_case.dart';
import 'package:ddara/domain/usecase/signup_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/provider/repository_provider.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(
    ref.read(authRepositoryProvider),
    ref.read(kakaoAuthProvider),
    ref.read(googleAuthProvider),
  );
});
