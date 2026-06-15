import 'package:ddara/core/model/auth/social_login_type.dart';

import '../../core/model/auth/login.dart';

abstract interface class AuthRepository {
  Future<Login> login(String token, SocialLoginType social);
}
