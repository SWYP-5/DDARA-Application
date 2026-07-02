import 'package:ddara/core/router/app_router.dart';
import 'package:ddara/data/provider/repository_provider.dart';
import 'package:ddara/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repo;

  /// authRepository 만 스텁으로 갈아끼운 컨테이너. (recoverSession 결과로 로그인 판별)
  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    repo = MockAuthRepository();
  });

  group('build (세션 복구 → 로그인 여부)', () {
    test('recoverSession 이 토큰을 주면 로그인(true)', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => 'fresh-token');
      final container = makeContainer();

      final isLoggedIn = await container.read(authStateProvider.future);

      expect(isLoggedIn, isTrue);
    });

    test('recoverSession 이 null 이면 비로그인(false)', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => null);
      final container = makeContainer();

      final isLoggedIn = await container.read(authStateProvider.future);

      expect(isLoggedIn, isFalse);
    });

    test('recoverSession 이 예외(타임아웃·네트워크 등)면 비로그인(false)', () async {
      // build 의 timeout(15초)·기타 오류는 동일한 catch 로 흡수되어 false 가 된다.
      when(() => repo.recoverSession()).thenThrow(Exception('network'));
      final container = makeContainer();

      final isLoggedIn = await container.read(authStateProvider.future);

      expect(isLoggedIn, isFalse);
    });
  });

  group('markLoggedOut (세션 만료·로그아웃 시 동기 확정)', () {
    test('로그인 상태에서 호출하면 인증 상태가 즉시 false 가 된다', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => 'fresh-token');
      final container = makeContainer();

      // 로그인 상태로 확정.
      expect(await container.read(authStateProvider.future), isTrue);

      container.read(authStateProvider.notifier).markLoggedOut();

      // 핵심: await 없이 곧바로 false 여야 한다.
      // (라우터 redirect 가 이 값을 동기로 읽어 login→home 바운스를 막는다.
      //  예전 invalidate 방식은 재계산 중 이전 값 true 를 유지해 바운스가 났다)
      final state = container.read(authStateProvider);
      expect(state, const AsyncData<bool>(false));
      expect(state.valueOrNull, isFalse);
    });

    test('markLoggedOut 은 recoverSession 을 다시 호출하지 않는다(재계산 없음)', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => 'fresh-token');
      final container = makeContainer();

      await container.read(authStateProvider.future); // 최초 1회 복구.
      container.read(authStateProvider.notifier).markLoggedOut();
      // 상태 변화가 재빌드를 유발하지 않는지 이벤트 큐를 비운 뒤 확인.
      await pumpEventQueue();

      verify(() => repo.recoverSession()).called(1);
      expect(container.read(authStateProvider).valueOrNull, isFalse);
    });
  });

  group('markLoggedIn (재로그인 시 로그인 상태 복귀)', () {
    test('로그아웃(false) 후 markLoggedIn 하면 다시 true 로 돌아온다', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => 'fresh-token');
      final container = makeContainer();
      final notifier = container.read(authStateProvider.notifier);

      // 로그인 → 로그아웃 → 같은 세션에서 재로그인 라운드트립.
      expect(await container.read(authStateProvider.future), isTrue);

      notifier.markLoggedOut();
      expect(container.read(authStateProvider).valueOrNull, isFalse);

      // routeAfterAuth 가 부르는 markLoggedIn 에 해당.
      notifier.markLoggedIn();

      // 핵심: 재로그인 후 isLoggedIn 이 즉시 true 로 복귀해야 redirect
      // (로그인 화면 재진입 → 홈) 가드가 정상 동작한다.
      final state = container.read(authStateProvider);
      expect(state, const AsyncData<bool>(true));
      expect(state.valueOrNull, isTrue);
    });

    test('markLoggedIn 은 recoverSession 재계산 없이 동기로 확정한다', () async {
      when(() => repo.recoverSession()).thenAnswer((_) async => null);
      final container = makeContainer();

      // 미로그인(null)으로 시작.
      expect(await container.read(authStateProvider.future), isFalse);

      container.read(authStateProvider.notifier).markLoggedIn();
      await pumpEventQueue();

      // 최초 build 1회 외에 추가 복구 호출이 없어야 한다.
      verify(() => repo.recoverSession()).called(1);
      expect(container.read(authStateProvider).valueOrNull, isTrue);
    });
  });
}