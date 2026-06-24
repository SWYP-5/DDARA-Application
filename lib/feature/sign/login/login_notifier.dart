import 'package:ddara/core/auth/provider/auth_provider.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/feature/sign/login/util/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exception/login_exception.dart';
import '../../../domain/provider/use_case_provider.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return Idle();
  }

  Future<void> socialLogin(BuildContext context, SocialLoginType social) async {
    final googleAuthService = ref.read(googleAuthProvider);
    final kakaoAuthService = ref.read(kakaoAuthProvider);

    switch (social) {
      case SocialLoginType.google:
        googleAuthService.signInWithGoogle(
          context,
          (token) => _login(token, social),
        );
      case SocialLoginType.kakao:
        kakaoAuthService.signInWithKakao(
          (token) => _login(token, social),
          (message) => state = LoginFail(message),
        );
    }
  }

  Future<void> _login(String token, SocialLoginType social) async {
    try {
      state = LoginLoading();

      final login = await ref.read(loginUseCaseProvider)(token, social);

      if (login.isNewUser) {
        state = SignupRequired(social);
      } else {
        state = LoginSuccess();
      }
    } on UnauthorizedException {
      state = LoginFail('Unauthorized');
    } on NetworkException {
      state = LoginFail('Network error');
    }
  }
}
