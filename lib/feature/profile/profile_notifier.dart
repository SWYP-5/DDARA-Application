import 'package:ddara/core/router/app_router.dart';
import 'package:ddara/domain/provider/use_case_provider.dart';
import 'package:ddara/feature/profile/util/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends AutoDisposeNotifier<ProfileState> {
  @override
  ProfileState build() {
    // 진입 시 프로필 정보를 자동 조회. (build 는 동기라 fire-and-forget)
    _load();

    return const ProfileState(isLoading: true);
  }

  /// 서버에서 사용자 프로필·앱 버전·연동 계정 정보를 가져와 상태에 저장한다.
  Future<void> _load() async {
    // build() 동기 실행 중 state 가 덮어써지지 않도록 await 로 한 틱 미룬다.
    // TODO: 프로필 조회 API/UseCase 연동 후 더미 데이터를 대체한다.
    //       (실제 구현 시 아래 await 자리에 API 호출이 들어간다)
    await Future<void>.delayed(Duration.zero);
    state = state.copyWith(
      isLoading: false,
      name: '따라쟁이',
      joinedAt: DateTime(2026, 6, 16),
      appVersion: 'v1.0.0',
      linkedAccount: '카카오',
    );
  }

  /// 로그아웃. 토큰·소셜 정보를 비우고(UseCase) 인증 상태를 무효화한다.
  Future<void> logout() async {
    if (state.logoutStatus == LogoutStatus.loading) return;

    state = state.copyWith(logoutStatus: LogoutStatus.loading);

    // 토큰·소셜타입 정리와 로그아웃 API 호출은 UseCase가 담당한다.
    final success = await ref.read(logoutUseCaseProvider).call();

    // 로컬 인증 정보는 이미 비워졌으므로, 라우터가 인증 상태를 다시 계산하도록
    // 무효화한다. (isLoggedIn → false)
    ref.invalidate(authStateProvider);

    state = state.copyWith(
      logoutStatus: success ? LogoutStatus.success : LogoutStatus.fail,
    );
  }
}
