import 'package:ddara/core/exception/sign_up_exception.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/domain/provider/use_case_provider.dart';
import 'package:ddara/feature/sign/signup/util/sign_up_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignNotifier extends FamilyNotifier<SignUpPageState, SocialLoginType> {
  @override
  SignUpPageState build(SocialLoginType social) {
    return SignUpPageState(social: social);
  }

  void nextButtonClicked() {
    state = state.copyWith(step: state.step + 1);
  }

  void termsAgreedChanged(bool agreed) {
    state = state.copyWith(termsAgreed: agreed);
  }

  void backButtonClicked() {
    state = state.copyWith(step: state.step - 1);
  }

  void birthDayOnChanged(String birth) {
    state = state.copyWith(birthDay: birth);
  }

  void nickNameOnChanged(String nickName) {
    state = state.copyWith(nickName: nickName);
  }

  Future<void> signUp() async {
    try {
      await ref.read(signUpUseCaseProvider)(
        state.social,
        state.termsAgreed,
        state.birthDay,
        state.nickName,
      );

      state = state.copyWith(isSuccess: true);
    } on TypeMisMatchException {
      state = state.copyWith(errorMessage: "잘못 된 형식이 있습니다.");
    } on AgeLimitException {
      state = state.copyWith(errorMessage: "나이가 너무 어립니다.");
    } on UnauthorizedTokenException {
      state = state.copyWith(errorMessage: "소셜 토큰이 만료 또는 무효 상태입니다.");
    } finally {
      state = state.copyWith(errorMessage: "");
    }
  }
}
