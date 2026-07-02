import 'package:ddara/core/deeplink/pending_invite.dart';
import 'package:ddara/core/permission/provider/permission_provider.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/provider/repository_provider.dart';
import '../../feature/group/create/group_create_page.dart';
import '../../feature/group/started/started_camera_page.dart';
import '../../feature/group/gallery/cycle_photo_gallery.dart';
import '../../feature/group/starter/starter_page.dart';
import '../../feature/group/detail/group_page.dart';
import '../../feature/group/join/join_group_page.dart';
import '../../feature/group/join/invite/invite_code_input_page.dart';
import '../../feature/group/join/landing/invite_landing_page.dart';
import '../../feature/home/home_page.dart';
import '../../feature/notification/notification_page.dart';
import '../../feature/onboarding/onboarding_page.dart';
import '../../feature/onboarding/provider/onboarding_provider.dart';
import '../../feature/permission/permission_page.dart';
import '../../feature/profile/profile_page.dart';
import '../../feature/profile/policy/policy_viewer_page.dart';
import '../../feature/profile/policy/terms_policy_page.dart';
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

/// authStateProvider 변화를 GoRouter 의 refreshListenable 로 잇는 브리지.
/// 인증 상태가 바뀌면 라우터를 재생성하지 않고 redirect 만 다시 평가하게 한다.
class _AuthRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final loginRoute = ref.read(initialRouteProvider);

  // 인증 상태가 바뀌면(로그아웃 등) 라우터를 재생성하지 않고 redirect 만 다시
  // 평가하도록 알린다. (이전엔 ref.watch 로 라우터 자체를 재생성해 스택이 초기화됐다)
  final refresh = _AuthRefreshNotifier();
  ref.onDispose(refresh.dispose);
  ref.listen(authStateProvider, (_, _) => refresh.refresh());

  // 초기 위치는 라우터 생성 시점(스플래시 단계에서 인증 상태가 이미 확정됨)에
  // 한 번만 계산한다. 이후 인증 변화는 refreshListenable + redirect 로 처리한다.
  final isLoggedIn = ref.read(authStateProvider).valueOrNull ?? false;
  final hasSeenOnboarding = ref.read(onboardingSeenProvider);

  // 콜드 스타트 초대 딥링크(main 에서 보관). 로그인 상태면 홈을 거치지 않고
  // 곧바로 landing 으로 진입한다. (미로그인이면 로그인 후 routeAfterAuth 가 소비)
  final pendingInvite = ref.read(pendingInviteCodeProvider);
  final hasPendingInvite = pendingInvite != null && pendingInvite.isNotEmpty;

  // 앱 최초 실행이면 온보딩, 그 외에는 인증·초대코드 상태에 따라 분기한다.
  final initialLocation = !hasSeenOnboarding
      ? RoutePath.onboarding
      : !isLoggedIn
      ? loginRoute
      : (hasPendingInvite
            ? '${RoutePath.inviteLanding}?code=$pendingInvite'
            : RoutePath.home);

  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: refresh,
    redirect: (context, state) async {
      // 라우터를 재생성하지 않으므로 매 평가 시 최신 인증 상태를 읽는다.
      final isLoggedIn = ref.read(authStateProvider).valueOrNull ?? false;

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
        path: RoutePath.termsPolicy,
        builder: (_, _) => const TermsPolicyPage(),
      ),
      GoRoute(
        path: RoutePath.policyViewer,
        builder: (_, state) =>
            PolicyViewerPage(args: state.extra! as PolicyViewerArgs),
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
        path: RoutePath.inviteCodeInput,
        // 딥링크로 전달된 초대코드를 쿼리 파라미터에서 읽는다.
        // 코드가 없으면 빈 문자열로 두어 페이지가 안내를 처리한다.
        builder: (_, state) => InviteCodeInputPage(
          inviteCode: state.uri.queryParameters['code'] ?? '',
        ),
      ),
      // 초대 링크 진입 → Lottie 재생 + 코드 조회 후 참여 확인으로 전환.
      // 진입도 슬라이드 대신 페이드로 부드럽게 들어온다.
      GoRoute(
        path: RoutePath.inviteLanding,
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, _, child) => FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          ),
          child: InviteLandingPage(
            inviteCode: state.uri.queryParameters['code'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RoutePath.joinGroup,
        // 랜딩 애니메이션이 끝난 뒤라 슬라이드 대신 페이드로 자연스럽게 전환한다.
        pageBuilder: (_, state) {
          final args = state.extra as JoinGroupArgs?;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, animation, _, child) {
              // 페이드 + 살짝 확대(0.96→1)로 콘텐츠가 떠오르듯 자연스럽게 전환.
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
                  child: child,
                ),
              );
            },
            child: JoinGroupPage(
              group: args?.group,
              inviteCode: args?.inviteCode ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: RoutePath.started,
        builder: (_, state) {
          return CyclePhotoGallery(cycleId: state.extra! as int);
        },
      ),
      GoRoute(
        path: RoutePath.starter,
        builder: (_, state) => StarterPage(groupId: state.extra! as int),
      ),
      GoRoute(
        path: RoutePath.startedCamera,
        builder: (_, state) =>
            StartedCameraPage(guideImageUrl: state.extra! as String),
      ),
    ],
  );
});
