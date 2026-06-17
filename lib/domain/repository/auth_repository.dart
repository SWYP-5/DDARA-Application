import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/domain/model/sign_up_command.dart';

import '../../core/model/auth/login.dart';

abstract interface class AuthRepository {
  Future<Login> login(String token, SocialLoginType social);

  Future<Login> signUp(SignUpCommand signUp);
}
