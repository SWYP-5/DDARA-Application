import 'package:ddara/core/model/auth/login.dart';
import 'package:ddara/domain/repository/auth_repository.dart';

import '../../core/model/auth/social_login_type.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Login> call(String token, SocialLoginType social) async {
    final login = await _authRepository.login(token, social);

    if (!login.isNewUser) {
      await _authRepository.saveAccessToken(login.accessToken);
      await _authRepository.saveRefreshToken(login.refreshToken);
    }

    return login;
  }
}
