import 'package:ddara/core/auth/provider/auth_provider.dart';
import 'package:ddara/domain/usecase/group/create_group_use_case.dart';
import 'package:ddara/domain/usecase/group/get_group_list_use_case.dart';
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

final createGroupUseCaseProvider = Provider<CreateGroupUseCase>((ref) {
  return CreateGroupUseCase(ref.read(groupRepositoryProvider));
});

final getGroupListUseCaseProvider = Provider<GetGroupListUseCase>((ref) {
  return GetGroupListUseCase(ref.read(groupRepositoryProvider));
});
