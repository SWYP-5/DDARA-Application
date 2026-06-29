import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoAuthService {
  // 카카오 로그인
  Future<void> signInWithKakao(
      Function(String) login,
      Function(String) errorFunc,
      ) async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        login(token.accessToken);
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        errorFunc('$error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          login(token.accessToken);
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        login(token.accessToken);
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<String?> getKakaoAccessToken() async {
    try {
      final token = await TokenManagerProvider.instance.manager.getToken();
      return token?.accessToken;
    } catch (e) {
      return null;
    }
  }

  Future<bool> hasToken() async {
    return await AuthApi.instance.hasToken();
  }

  Future<bool> availabilityToken() async {
    try {
      await UserApi.instance.accessTokenInfo();
      return true;
    } catch (e) {
      return false;
    }
  }

  // 카카오 로그아웃 (토큰 만료 처리)
  Future<void> logout() async {
    try {
      await UserApi.instance.logout();
      print('카카오 로그아웃 성공');
    } catch (error) {
      // 이미 토큰이 없는 경우 등은 로그아웃된 것으로 간주.
      print('카카오 로그아웃 실패 $error');
    }
  }
}
