import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/feature/login/provider/notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('로그인 페이지'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => notifier.socialLogin(SocialLoginType.google),
              child: const Text('구글 로그인'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => notifier.socialLogin(SocialLoginType.kakao),
              child: const Text('카카오 로그인'),
            ),
          ],),
      ),
    );
  }
}
