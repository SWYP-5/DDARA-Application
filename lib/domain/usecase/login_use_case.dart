import 'package:ddara/core/model/auth/login.dart';
import 'package:ddara/domain/repository/auth_repository.dart';

import '../../core/model/auth/social_login_type.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  Future<Login> call(String token, SocialLoginType social) async {
    return await _authRepository.login(token, social);
  }
}
