import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleAuthService _instance = GoogleAuthService._internal();

  factory GoogleAuthService() => _instance;

  GoogleAuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // iOS에서만 clientId 필요
    clientId: (!kIsWeb && Platform.isIOS)
        ? dotenv.get('GOOGLE_IOS_CLIENT_ID')
        : null,
  );

  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentUser => _currentUser;

  Future<String?> getGoogleAccessToken() async {
    final user = _googleSignIn.currentUser;

    if (user != null) {
      final auth = await user.authentication;
      return auth.accessToken;
    } else {
      return null;
    }
  }

  /// 구글 프로필 표시 이름을 반환한다. 세션이 없으면 null.
  /// (회원가입 시 닉네임 대신 소셜 프로필 이름으로 사용)
  String? getGoogleName() => _googleSignIn.currentUser?.displayName;

  Future<bool> isLogin() async {
    final user = _googleSignIn.currentUser;
    return user != null;
  }

  /// UI 없이 이전 구글 세션을 복원해 accessToken 을 반환한다.
  /// 캐시된 세션이 없거나 복원 실패면 null. (토큰 만료 시 무중단 재인증용)
  Future<String?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) return null;

      _currentUser = account;
      final auth = await account.authentication;
      return auth.accessToken;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signInWithGoogle(
    BuildContext context,
    Function(String) login,
  ) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        _currentUser = googleUser;

        if (context.mounted) {
          print('✅ 구글 로그인 성공: ${googleUser.displayName} (${googleUser.email})');

          final auth = await googleUser.authentication;

          print('✅ Access Token: ${auth.accessToken}');
          login(auth.accessToken!);
        }

        return true;
      } else {
        print('❌ googleUser가 null입니다 (사용자가 취소했거나 실패)');
      }

      return false;
    } catch (e, stackTrace) {
      print('❌ 구글 로그인 에러: $e');
      print('❌ 스택 트레이스: $stackTrace');
      if (context.mounted) {
        _showErrorMessage(context, '구글 로그인 실패: $e');
      }
      return false;
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    print('❌ 에러 메시지: $message');
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
    } catch (e) {
      print('로그아웃 실패: $e');
    }
  }
}
