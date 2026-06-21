import 'package:ddara/core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/provider/repository_provider.dart';
import '../../feature/home/home_page.dart';
import '../../feature/login/login_page.dart';
import '../../feature/onboarding/onboarding_page.dart';
import '../../feature/onboarding/provider/onboarding_provider.dart';
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
  final loginRoute = ref.read(initialRouteProvider);
  final auth = ref.watch(authStateProvider);

  // 네이티브 스플래시가 유지되는 동안 main 에서 authStateProvider 를 미리
  // 확정하므로, 라우터가 만들어질 때 인증 상태는 이미 결정되어 있다.
  final isLoggedIn = auth.valueOrNull ?? false;
  final hasSeenOnboarding = ref.read(onboardingSeenProvider);

  // 앱 최초 실행이면 온보딩, 그 외에는 인증 상태에 따라 분기한다.
  final initialLocation = !hasSeenOnboarding
      ? RoutePath.onboarding
      : (isLoggedIn ? RoutePath.home : loginRoute);

  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) {
      // 로그인 상태에서 로그인 화면으로 가려 하면 홈으로 보낸다.
      if (isLoggedIn && state.matchedLocation == RoutePath.login) {
        return RoutePath.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePath.onboarding,
        builder: (_, _) => const OnboardingPage(),
      ),
      GoRoute(path: RoutePath.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: RoutePath.home, builder: (_, _) => const HomePage()),
      GoRoute(path: RoutePath.signup, builder: (_, _) => const SignUpPage()),
    ],
  );
});
