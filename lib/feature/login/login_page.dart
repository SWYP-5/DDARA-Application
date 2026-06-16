import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/login/provider/notifier_provider.dart';
import 'package:ddara/feature/login/util/login_state.dart';
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
          context.push(RoutePath.signup);

        case LoginFail(message: final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );

        default:
          break;
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('로그인 페이지'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => notifier.socialLogin(context, SocialLoginType.google),
              child: const Text('구글 로그인'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => notifier.socialLogin(context, SocialLoginType.kakao),
              child: const Text('카카오 로그인'),
            ),
          ],),
      ),
    );
  }
}
