import 'package:ddara/core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../feature/home/home_page.dart';
import '../../feature/login/login_page.dart';
import '../../feature/signup/sign_up_page.dart';

final initialRouteProvider = Provider<String>((ref) => RoutePath.login);

final routerProvider = Provider<GoRouter>((ref) {
  final initialRoute = ref.read(initialRouteProvider);

  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(path: RoutePath.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: RoutePath.home, builder: (_, _) => const HomePage()),
      GoRoute(path: RoutePath.signup, builder: (_, _) => const SignUpPage()),
    ],
  );
});
