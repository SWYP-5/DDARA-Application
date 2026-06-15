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

  Future<bool> signInWithGoogle(BuildContext context, Function(String) login) async {
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
