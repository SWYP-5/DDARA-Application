import 'package:ddara/core/model/auth/login.dart';
import 'package:ddara/core/network/dto/auth/login_response.dart';

extension LoginMapper on LoginResponse {
  Login toDomain() {
    return Login(
      isNewUser: isNewUser,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
