import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/app_router.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/data/provider/repository_provider.dart';
import 'package:ddara/feature/profile/provider/profile_provider.dart';
import 'package:ddara/feature/profile/widget/profile_header.dart';
import 'package:ddara/feature/profile/widget/profile_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 프로필 화면. (현재는 테스트용 — 로그아웃 버튼만 있음)
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '프로필', onBack: () => context.pop()),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: AppSpacing.s3,
            left: AppSpacing.s4,
            right: AppSpacing.s4,
            bottom: AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s5,
            children: [
              ProfileHeader(name: profile.name),
              ProfileSection(
                label: '기본 정보',
                children: [
                  ProfileRow(
                    label: '가입일',
                    value: _formatDate(profile.joinedAt),
                  ),
                ],
              ),
              ProfileSection(
                label: '알림',
                children: [
                  ProfileRow(
                    label: '알림 설정',
                    trailing: const ProfileChevron(),
                    onTap: () => context.push(RoutePath.notificationSettings),
                  ),
                ],
              ),
              ProfileSection(
                label: '지원',
                children: [
                  ProfileRow(
                    label: '약관 및 정책',
                    trailing: const ProfileChevron(),
                    onTap: () => context.push(RoutePath.termsPolicy),
                  ),
                  ProfileRow(
                    label: '문의하기',
                    trailing: const ProfileChevron(),
                    onTap: () {
                      // TODO: 문의하기 화면으로 이동.
                    },
                  ),
                  ProfileRow(label: '앱 버전', value: ref.watch(appVersionProvider)),
                ],
              ),
              ProfileSection(
                label: '계정',
                children: [
                  ProfileRow(
                    label: '연동 계정',
                    value: ref.watch(linkedAccountProvider),
                  ),
                  ProfileRow(
                    label: '로그아웃',
                    labelColor: AppColors.statusDanger,
                    onTap: () => _confirmLogout(context, ref),
                  ),
                  ProfileRow(
                    label: '회원 탈퇴',
                    onTap: () {
                      // TODO: 회원 탈퇴 처리.
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// DateTime → 'yyyy.MM.dd'.
  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}.$month.$day';
  }

  /// 로그아웃 확인 다이얼로그를 띄우고, 확인 시에만 로그아웃을 진행한다.
  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final ok = await AppDialog.show(
      context,
      title: '로그아웃 할까요?',
      confirmLabel: '로그아웃',
    );
    if (ok && context.mounted) await _logout(context, ref);
  }

  /// 로그아웃. 저장된 토큰을 비우고 로그인 화면으로 보낸다.
  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.saveAccessToken(null);
    await repo.saveRefreshToken(null);
    // 무중단 재인증 분기 정보도 함께 비워, 강제 로그아웃과 동작을 일치시킨다.
    await repo.deleteSocialLoginType();
    // 라우터가 인증 상태를 다시 계산하도록 무효화. (isLoggedIn → false)
    ref.invalidate(authStateProvider);
    if (context.mounted) context.go(RoutePath.login);
  }
}
