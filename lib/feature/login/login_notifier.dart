import 'package:ddara/core/auth/provider/auth_provider.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/feature/login/util/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../core/exception/login_exception.dart';
import '../../domain/provider/use_case_provider.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<void> socialLogin(BuildContext context, SocialLoginType social) async {
    final googleAuthService = ref.read(googleAuthProvider);

    switch(social){
      case SocialLoginType.google:
        googleAuthService.signInWithGoogle(context, (token) => _login(token, social));
      case SocialLoginType.kakao:
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          _login(token.accessToken, social);
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');
        }
    }
  }

  Future<void> _login(String token, SocialLoginType social) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final login = await ref.read(loginUseCaseProvider)(token, social);

      state = state.copyWith(isLoading: false);

      if(login.isNewUser){
        //todo 회원가입 진행
        print('신규 회원입니다. 회원가입을 진행해주세요.');
      } else {
        //todo 로그인 진행
        print('기존 회원입니다. 로그인을 진행해주세요.');
      }

    } on UnauthorizedException {
      state = state.copyWith(isLoading: false, errorMessage: 'Unauthorized');
    } on NetworkException {
      state = state.copyWith(isLoading: false, errorMessage: 'Network error');
    }
  }
}
