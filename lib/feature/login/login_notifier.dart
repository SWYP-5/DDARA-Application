import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/feature/login/util/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exception/login_exception.dart';
import '../../domain/provider/use_case_provider.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<void> login(String token, SocialLoginType social) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final login = await ref.read(loginUseCaseProvider)(token, social);

      state = state.copyWith(isLoading: false);

      if(login.isNewUser){
        //todo 회원가입 진행
      } else {
        //todo 로그인 진행
      }
      
    } on UnauthorizedException {
      state = state.copyWith(isLoading: false, errorMessage: 'Unauthorized');
    } on NetworkException {
      state = state.copyWith(isLoading: false, errorMessage: 'Network error');
    }
  }
}
