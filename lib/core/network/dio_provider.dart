import 'package:ddara/core/local/provider/local_provider.dart';
import 'package:ddara/core/local/storage_key.dart';
import 'package:ddara/core/network/auth_interceptor.dart';
import 'package:ddara/core/router/app_router.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/data/provider/repository_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: dotenv.get('API_BASE_URL'),
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  headers: {'Content-Type': 'application/json'},
);

// 명시적 타입으로 provider 타입 추론 순환을 끊는다.
// (콜백이 authRepositoryProvider·authStateProvider 를 지연 참조 → 런타임 순환 없음)
final Provider<Dio> dioProvider = Provider<Dio>((ref) {
  final dio = Dio(_baseOptions());

  // 재시도 전용 Dio. 인터셉터를 달지 않아 재시도·재귀 루프를 막는다.
  final retryDio = Dio(_baseOptions());

  final storage = ref.read(secureStorageProvider);

  dio.interceptors.add(
    AuthInterceptor(
      storage: storage,
      retryDio: retryDio,
      recoverSession: () => ref.read(authRepositoryProvider).recoverSession(),
      onSessionExpired: () async {
        // 이미 비워졌으면(다른 401 핸들러가 처리) 중복 동작하지 않는다. (1회 가드)
        final hasToken =
            await storage.read(key: StorageKey.accessToken) != null;
        if (!hasToken) return;

        await storage.delete(key: StorageKey.accessToken);
        await storage.delete(key: StorageKey.refreshToken);
        await storage.delete(key: StorageKey.socialLoginType);

        // 인증 상태 무효화(라우터 redirect 재평가용) 후, 로그인 화면으로 직접 이동.
        // 라우터를 재생성하지 않으므로 명시적으로 보낸다. (invalidate 를 먼저 해야
        // isLoggedIn=false 가 되어 login→home 바운스가 일어나지 않는다)
        ref.invalidate(authStateProvider);
        ref.read(routerProvider).go(RoutePath.login);
      },
    ),
  );

  return dio;
});
