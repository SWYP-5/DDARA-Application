import 'package:ddara/core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/provider/repository_provider.dart';
import '../../feature/home/home_page.dart';
import '../../feature/login/login_page.dart';
import '../../feature/signup/sign_up_page.dart';

final initialRouteProvider = Provider<String>((ref) => RoutePath.login);

final authStateProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(authRepositoryProvider);
  final refreshToken = await repo.getRefreshToken();

  if(refreshToken == null) return false;

  final accessToken = await repo.refreshAccessToken(refreshToken);
  await repo.saveAccessToken(accessToken);

  return true;
});

final routerProvider = Provider<GoRouter>((ref) {
  final initialRoute = ref.read(initialRouteProvider);
  final auth = ref.watch(authStateProvider);

  // 네이티브 스플래시가 유지되는 동안 main 에서 authStateProvider 를 미리
  // 확정하므로, 라우터가 만들어질 때 인증 상태는 이미 결정되어 있다.
  final isLoggedIn = auth.valueOrNull ?? false;

  return GoRouter(
    initialLocation: isLoggedIn ? RoutePath.home : initialRoute,
    redirect: (context, state) {
      // 로그인 상태에서 로그인 화면으로 가려 하면 홈으로 보낸다.
      if (isLoggedIn && state.matchedLocation == RoutePath.login) {
        return RoutePath.home;
      }

      return null;
    },
    routes: [
      GoRoute(path: RoutePath.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: RoutePath.home, builder: (_, _) => const HomePage()),
      GoRoute(path: RoutePath.signup, builder: (_, _) => const SignUpPage()),
    ],
  );
});
