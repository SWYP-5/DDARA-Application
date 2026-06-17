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

  return GoRouter(
    initialLocation: initialRoute,
    redirect: (context, state) {
      final isLoggedIn = auth.valueOrNull ?? false;
      final goingToLogin = state.matchedLocation == RoutePath.login;

      if (isLoggedIn && goingToLogin) {
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
