import 'package:ddara/core/designsystem/theme/app_colors.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/login/provider/notifier_provider.dart';
import 'package:ddara/feature/login/util/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(loginNotifierProvider.notifier);

    ref.listen(loginNotifierProvider, (previous, next) {
      switch (next) {
        case LoginSuccess():
          context.go(RoutePath.home);

        case SignupRequired():
          context.push(RoutePath.signup, extra: next.social);

        case LoginFail(message: final message):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));

        default:
          break;
      }
    });

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            // 브랜딩 영역
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      'ddara.',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 46,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '우리끼리 따라찍기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                        letterSpacing: -0.16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 소셜 로그인 영역
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  _SocialLoginButton(
                    label: '카카오로 시작하기',
                    backgroundColor: const Color(0xFFFEE500),
                    foregroundColor: const Color(0xFF000000),
                    onPressed: () =>
                        notifier.socialLogin(context, SocialLoginType.kakao),
                  ),
                  _SocialLoginButton(
                    label: 'Google로 시작하기',
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: const Color(0xFF000000),
                    onPressed: () =>
                        notifier.socialLogin(context, SocialLoginType.google),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '이용약관과 개인정보 처리방침 확인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                      letterSpacing: -0.12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 소셜 로그인 버튼. (브랜드 색 기반 · 전체폭)
class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 16,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          letterSpacing: -0.16,
        ),
      ),
    );
  }
}
