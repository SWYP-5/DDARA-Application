import 'package:ddara/core/auth/google_auth_service.dart';
import 'package:ddara/core/auth/kakao_auth_service.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/domain/model/sign_up_command.dart';
import 'package:ddara/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;
  final KakaoAuthService _kakaoAuthService;
  final GoogleAuthService _googleAuthService;

  SignUpUseCase(
    this._authRepository,
    this._kakaoAuthService,
    this._googleAuthService,
  );

  Future<void> call(SocialLoginType type, bool termsAgreed) async {
    // 닉네임 입력 화면을 제거하고, 소셜 로그인 프로필 이름을 닉네임으로 사용한다.
    final (token, name) = switch (type) {
      SocialLoginType.kakao => (
        await _kakaoAuthService.getKakaoAccessToken(),
        await _kakaoAuthService.getKakaoName(),
      ),
      SocialLoginType.google => (
        await _googleAuthService.getGoogleAccessToken(),
        _googleAuthService.getGoogleName(),
      ),
    };

    // final response = await _authRepository.signUp(
    //   SignUpCommand(
    //     provider: type.value,
    //     accessToken: token!,
    //     // 생일 입력 화면 제거. API 에서 birthDate 필드가 빠지면 함께 정리한다.
    //     birthDate: '',
    //     termsAgreed: termsAgreed,
    //     nickname: name ?? '',
    //   ),
    // );

    // await _authRepository.saveAccessToken(response.accessToken);
    // await _authRepository.saveRefreshToken(response.refreshToken);
    // // 토큰 만료 시 무중단 재인증에서 분기하도록 소셜 종류도 저장.
    // await _authRepository.saveSocialLoginType(type);
  }
}
