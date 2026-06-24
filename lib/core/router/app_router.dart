import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/provider/repository_provider.dart';
import '../../feature/group/create/group_create_page.dart';
import '../../feature/group/detail/group_page.dart';
import '../../feature/group/join/group_join_page.dart';
import '../../feature/home/home_page.dart';
import '../../feature/onboarding/onboarding_page.dart';
import '../../feature/onboarding/provider/onboarding_provider.dart';
import '../../feature/permission/permission_page.dart';
import '../../feature/profile/profile_page.dart';
import '../../feature/permission/required_permission_page.dart';
import '../../feature/sign/login/login_page.dart';
import '../../feature/sign/signup/sign_up_page.dart';

final initialRouteProvider = Provider<String>((ref) => RoutePath.login);

final authStateProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(authRepositoryProvider);
  final refreshToken = await repo.getRefreshToken();

  if (refreshToken == null) return false;

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
    redirect: (context, state) async {
      // 로그인 상태에서 로그인 화면으로 가려 하면 홈으로 보낸다.
      if (isLoggedIn && state.matchedLocation == RoutePath.login) {
        return RoutePath.home;
      }

      // 홈 진입 직전, 카메라 권한이 없으면 권한 안내 화면으로 우회시킨다.
      // 로그인/회원가입 직후는 물론, 앱 실행 시 홈으로 분기되는 경우(자동 로그인)
      // 까지 이 한 곳에서 게이트가 동작한다.
      if (state.matchedLocation == RoutePath.home) {
        // 이번 실행에서 이미 안내를 본 경우엔 통과시킨다.
        if (ref.read(cameraNoticeAcknowledgedProvider)) return null;

        final granted = await ref
            .read(permissionServiceProvider)
            .isCameraGranted();
        if (!granted) return RoutePath.permission;
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
      GoRoute(
        path: RoutePath.permission,
        builder: (_, _) => const PermissionPage(),
      ),
      GoRoute(
        path: RoutePath.requiredPermission,
        builder: (_, _) => const RequiredPermissionPage(),
      ),
      GoRoute(path: RoutePath.group, builder: (_, _) => const GroupPage()),
      GoRoute(path: RoutePath.profile, builder: (_, _) => const ProfilePage()),
      GoRoute(
        path: RoutePath.groupCreate,
        builder: (_, _) => const GroupCreatePage(),
      ),
      GoRoute(
        path: RoutePath.groupJoin,
        // 딥링크로 전달된 초대코드를 쿼리 파라미터에서 읽는다.
        // 코드가 없으면 빈 문자열로 두어 페이지가 안내를 처리한다.
        builder: (_, state) =>
            GroupJoinPage(inviteCode: state.uri.queryParameters['code'] ?? ''),
      ),
    ],
  );
});
