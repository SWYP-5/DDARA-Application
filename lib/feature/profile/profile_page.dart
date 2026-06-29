import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/feature/profile/provider/notifier_provider.dart';
import 'package:ddara/feature/profile/util/profile_state.dart';
import 'package:ddara/feature/profile/widget/profile_header.dart';
import 'package:ddara/feature/profile/widget/profile_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 프로필 화면.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    // 로그아웃 결과에 따라 분기: 성공 시 로그인 화면으로 이동, 실패 시 안내.
    ref.listen(profileNotifierProvider.select((s) => s.logoutStatus), (
      _,
      status,
    ) {
      if (!context.mounted) return;
      switch (status) {
        case LogoutStatus.success:
          context.go(RoutePath.login);
        case LogoutStatus.fail:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('로그아웃에 실패했어요.')));
        case LogoutStatus.idle:
        case LogoutStatus.loading:
          break;
      }
    });

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
              ProfileHeader(name: state.name),
              ProfileSection(
                label: '기본 정보',
                children: [
                  ProfileRow(
                    label: '가입일',
                    value: _formatDate(state.joinedAt),
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
                  ProfileRow(label: '앱 버전', value: state.appVersion),
                ],
              ),
              ProfileSection(
                label: '계정',
                children: [
                  ProfileRow(label: '연동 계정', value: state.linkedAccount),
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

  /// DateTime → 'yyyy.MM.dd'. (없으면 빈 문자열)
  String _formatDate(DateTime? date) {
    if (date == null) return '';
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
    if (ok) await ref.read(profileNotifierProvider.notifier).logout();
  }
}
