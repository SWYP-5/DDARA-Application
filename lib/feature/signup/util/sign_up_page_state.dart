import 'package:ddara/core/model/auth/social_login_type.dart';

class SignUpPageState {
  final SocialLoginType social;
  final int step;
  final bool termsAgreed;
  final String birthDay;
  final String nickName;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignUpPageState({
    required this.social,
    this.step = 1,
    this.termsAgreed = false,
    this.birthDay = '',
    this.nickName = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignUpPageState copyWith({
    SocialLoginType? social,
    int? step,
    bool? termsAgreed,
    String? birthDay,
    String? nickName,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpPageState(
      social: social ?? this.social,
      step: step ?? this.step,
      termsAgreed: termsAgreed ?? this.termsAgreed,
      birthDay: birthDay ?? this.birthDay,
      nickName: nickName ?? this.nickName,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
