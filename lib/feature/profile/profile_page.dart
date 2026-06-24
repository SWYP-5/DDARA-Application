import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/app_router.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/data/provider/repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 프로필 화면. (현재는 테스트용 — 로그아웃 버튼만 있음)
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '프로필', onBack: () => context.pop()),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            child: AppButton(
              label: '로그아웃',
              onPressed: () => _logout(context, ref),
            ),
          ),
        ),
      ),
    );
  }

  /// 테스트용 로그아웃. 저장된 토큰을 비우고 로그인 화면으로 보낸다.
  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.saveAccessToken(null);
    await repo.saveRefreshToken(null);
    // 라우터가 인증 상태를 다시 계산하도록 무효화. (isLoggedIn → false)
    ref.invalidate(authStateProvider);
    if (context.mounted) context.go(RoutePath.login);
  }
}
