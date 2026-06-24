import 'dart:async';
import 'dart:ui';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/deeplink/deep_link_service.dart';
import 'core/deeplink/pending_invite.dart';
import 'core/designsystem/theme/app_theme.dart';
import 'core/local/provider/local_provider.dart';
import 'core/router/app_router.dart';
import 'core/router/route_path.dart';
import 'data/provider/repository_provider.dart';
import 'feature/onboarding/provider/onboarding_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 인증 상태 확인이 끝날 때까지 네이티브 스플래시를 화면에 유지한다.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: '.env');

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Flutter 프레임워크에서 발생한 에러를 Crashlytics 로 보고
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // 프레임워크가 잡지 못한 비동기/플랫폼 에러를 Crashlytics 로 보고
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlayStyle);

  // 온보딩 플래그 등을 동기적으로 읽을 수 있도록 SharedPreferences 를 미리 로드
  final prefs = await SharedPreferences.getInstance();

  // 라우터가 초기 분기에 사용할 수 있도록 인증 상태를 미리 확정
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  try {
    await container.read(authStateProvider.future);
  } catch (_) {
    // 인증 확인 실패 시 비로그인으로 처리
  }

  FlutterNativeSplash.remove();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSub;
  late final DeepLinkService _deepLink;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    _deepLink = DeepLinkService(onInvite: _onInvite);
    // 라우터가 초기 위치를 잡은 뒤 딥링크를 처리하도록 첫 프레임 이후 초기화.
    WidgetsBinding.instance.addPostFrameCallback((_) => _deepLink.init());
  }

  /// 딥링크를 app_links 로 직접 수신한다.
  ///
  /// Flutter 기본 딥링크 자동 라우팅(FlutterDeepLinkingEnabled)을 꺼두었으므로,
  /// 콜드 스타트(getInitialLink)와 실행 중(uriLinkStream) 양쪽을 직접 구독한다.
  Future<void> _initDeepLinks() async {
    final initial = await _appLinks.getInitialLink();
    if (initial != null) _handleUri(initial);
    _linkSub = _appLinks.uriLinkStream.listen(_handleUri);
  }

  /// 들어온 딥링크를 스킴·host 기준으로 분기한다.
  void _handleUri(Uri uri) {
    // 카카오 로그인 콜백(kakao{appkey}://oauth)은 KakaoSDK 가 자체 처리하므로
    // 여기서 라우팅하면 안 된다. (go_router 로 흘리면 토큰 교환 실패)
    if (uri.scheme.startsWith('kakao')) {
      if (uri.host == 'oauth') return;
      if (uri.host == 'kakaolink') {
        // TODO: 카카오톡 공유 진입 파라미터 파싱 후 라우팅.
        // 예) ref.read(routerProvider).go('/group/${uri.queryParameters['id']}');
        return;
      }
    }
    // TODO: 기타 딥링크(푸시·유니버설 링크 등) 처리.
  }

  /// 딥링크에서 받은 초대코드로 모임 참여 흐름을 시작한다.
  ///
  /// 딥링크는 로그아웃·권한 미허용 상태에서도 외부에서 진입할 수 있으므로,
  /// 초대코드를 보관해두고 상황에 맞는 화면으로 보낸다. (로그인/온보딩/권한)
  /// 각 단계가 끝나면 routeAfterAuth 가 보관된 코드로 참여 화면에 복귀시킨다.
  Future<void> _onInvite(String inviteCode) async {
    final router = ref.read(routerProvider);
    final token = await ref.read(authRepositoryProvider).getAccessToken();

    // 초대코드는 항상 보관한다. (권한 게이트 통과 후 routeAfterAuth 가 소비)
    ref.read(pendingInviteCodeProvider.notifier).state = inviteCode;

    // 미로그인 상태면 인증 흐름부터. (첫 진입이면 온보딩, 그 외엔 로그인)
    if (token == null || token.isEmpty) {
      final seenOnboarding = ref.read(onboardingSeenProvider);
      router.go(seenOnboarding ? RoutePath.login : RoutePath.onboarding);
      return;
    }

    // 로그인됨 → 권한 게이트를 거쳐 참여 화면으로. (권한 없으면 PermissionPage)
    await routeAfterAuth(ref, router);
  }

  @override
  void dispose() {
    _deepLink.dispose();
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return CupertinoApp.router(
      title: 'Ddara',
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
