import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/data/provider/repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(authRepositoryProvider);

    // 저장된 토큰을 비워 로그인 상태를 해제한다.
    await repo.saveAccessToken(null);
    await repo.saveRefreshToken(null);

    // 라우터가 참조하는 인증 상태를 갱신해 로그인 화면으로 보낸다.
    ref.invalidate(authStateProvider);

    if (context.mounted) context.go(RoutePath.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            Text(
              'Home Page',
              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            CupertinoButton.filled(
              onPressed: () => _logout(context, ref),
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
