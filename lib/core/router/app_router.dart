import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/provider/repository_provider.dart';
import '../../feature/group/create/group_create_page.dart';
import '../../feature/group/started/started_camera_page.dart';
import '../../feature/group/started/started_photo_check_page.dart';
import '../../feature/group/started/started_page.dart';
import '../../feature/group/starter/starter_page.dart';
import '../../feature/group/detail/group_page.dart';
import '../../feature/group/join/group_join_page.dart';
import '../../feature/home/home_page.dart';
import '../../feature/notification/notification_page.dart';
import '../../feature/onboarding/onboarding_page.dart';
import '../../feature/onboarding/provider/onboarding_provider.dart';
import '../../feature/permission/permission_page.dart';
import '../../feature/profile/profile_page.dart';
import '../../feature/profile/settings/notification_settings.dart';
import '../../feature/permission/required_permission_page.dart';
import '../../feature/sign/login/login_page.dart';
import '../../feature/sign/signup/sign_up_page.dart';

final initialRouteProvider = Provider<String>((ref) => RoutePath.login);

final authStateProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(authRepositoryProvider);

  // 세션 복구(재발급 → 실패 시 소셜 무중단 재인증)를 시도. 토큰을 얻으면 로그인.
  // 콜드 스타트 스플래시가 오래 잡히지 않도록 타임아웃 후 비로그인으로 떨어뜨린다.
  try {
    final token = await repo.recoverSession().timeout(
      const Duration(seconds: 15),
    );
    return token != null;
  } catch (_) {
    // 타임아웃·네트워크 오류 등 → 비로그인 처리.
    return false;
  }
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
      GoRoute(
        path: RoutePath.group,
        builder: (_, state) => GroupPage(groupId: state.extra! as int),
      ),
      GoRoute(path: RoutePath.profile, builder: (_, _) => const ProfilePage()),
      GoRoute(
        path: RoutePath.notificationSettings,
        builder: (_, _) => const NotificationSettings(),
      ),
      GoRoute(
        path: RoutePath.notification,
        builder: (_, _) => const NotificationPage(),
      ),
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
      GoRoute(
        path: RoutePath.started,
        builder: (_, _) => const StartedPage(),
      ),
      GoRoute(
        path: RoutePath.starter,
        builder: (_, _) => const StarterPage(),
      ),
      GoRoute(
        path: RoutePath.startedCamera,
        builder: (_, _) => const StartedCameraPage(),
      ),
      GoRoute(
        path: RoutePath.startedPhotoCheck,
        builder: (_, state) =>
            StartedPhotoCheckPage(imagePath: state.extra! as String),
      ),
    ],
  );
});
